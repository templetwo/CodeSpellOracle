import Foundation

enum PythonExecutionError: Error {
    case timeout
    case syntaxError(String)
    case runtimeError(String)
    case securityViolation(String)
    case unknownError(String)
}

struct PythonExecutionResult {
    let success: Bool
    let output: String
    let error: String?
    let executionTime: TimeInterval
}

actor PythonSandboxService {
    private let pythonPath: String
    private let timeoutSeconds: TimeInterval = 5.0
    private let maxOutputLength = 10000
    
    // Dangerous imports to block
    private let blockedImports = [
        "os", "sys", "subprocess", "shutil", "pathlib",
        "socket", "urllib", "requests", "multiprocessing",
        "__import__", "eval", "exec", "compile", "open"
    ]
    
    init() {
        self.pythonPath = PythonSandboxService.findSystemPython()
    }
    
    nonisolated static func findSystemPython() -> String {
        // Allow override via UserDefaults
        if let custom = UserDefaults.standard.string(forKey: "pythonExecutablePath"),
           FileManager.default.isExecutableFile(atPath: custom) {
            return custom
        }
        let candidates = [
            "/opt/homebrew/bin/python3",
            "/usr/local/bin/python3",
            "/Library/Frameworks/Python.framework/Versions/Current/bin/python3",
            "/Library/Frameworks/Python.framework/Versions/3.13/bin/python3",
            "/usr/bin/python3"
        ]
        for path in candidates {
            if FileManager.default.isExecutableFile(atPath: path) {
                return path
            }
        }
        return "/usr/bin/python3"
    }
    
    func getResolvedPythonPath() -> String {
        return pythonPath
    }
    
    func validateCode(_ code: String) throws {
        // Check for dangerous imports
        for blocked in blockedImports {
            if code.contains("import \(blocked)") || 
               code.contains("from \(blocked)") {
                throw PythonExecutionError.securityViolation(
                    "Blocked import: \(blocked). This module is not allowed for security reasons."
                )
            }
        }
        
        // Check for dangerous builtins
        let dangerousPatterns = [
            "__import__", "eval(", "exec(", "compile(",
            "open(", "file(", "input(", "raw_input("
        ]
        
        for pattern in dangerousPatterns {
            if code.contains(pattern) {
                throw PythonExecutionError.securityViolation(
                    "Blocked operation: \(pattern). This operation is not allowed."
                )
            }
        }
    }
    
    func execute(code: String) async throws -> PythonExecutionResult {
        let startTime = Date()
        
        // Validate code first
        try validateCode(code)
        
        // Create temporary directory for execution
        let tempDir = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
        try FileManager.default.createDirectory(at: tempDir, withIntermediateDirectories: true)
        
        defer {
            try? FileManager.default.removeItem(at: tempDir)
        }
        
        // Write code to temporary file
        let scriptPath = tempDir.appendingPathComponent("script.py")
        try code.write(to: scriptPath, atomically: true, encoding: .utf8)
        
        // Create process
        let process = Process()
        process.executableURL = URL(fileURLWithPath: pythonPath)
        process.arguments = ["-I", "-S", scriptPath.path]  // -I: isolated mode, -S: no site packages
        process.currentDirectoryURL = tempDir
        
        // Set up pipes for output
        let outputPipe = Pipe()
        let errorPipe = Pipe()
        process.standardOutput = outputPipe
        process.standardError = errorPipe
        
        // Execute with timeout
        let result = try await withTimeout(seconds: timeoutSeconds) {
            try await self.executeProcess(process, outputPipe: outputPipe, errorPipe: errorPipe)
        }
        
        let executionTime = Date().timeIntervalSince(startTime)
        
        return PythonExecutionResult(
            success: result.error == nil,
            output: result.output,
            error: result.error,
            executionTime: executionTime
        )
    }
    
    func testFunction(
        code: String,
        functionName: String,
        testCases: [TestCase]
    ) async throws -> [TestResult] {
        var results: [TestResult] = []
        
        for testCase in testCases {
            // Build test code
            let testCode = buildTestCode(
                userCode: code,
                functionName: functionName,
                inputs: testCase.inputs,
                expectedOutput: testCase.expectedOutput
            )
            
            do {
                let result = try await execute(code: testCode)
                let testResult = parseTestResult(result, testCase: testCase)
                results.append(testResult)
            } catch {
                results.append(TestResult(
                    testCase: testCase,
                    passed: false,
                    actualOutput: nil,
                    error: error.localizedDescription
                ))
            }
        }
        
        return results
    }
    
    private func buildTestCode(
        userCode: String,
        functionName: String,
        inputs: [String],
        expectedOutput: String
    ) -> String {
        let inputsStr = inputs.map { "\"\($0)\"" }.joined(separator: ", ")
        
        return [
            "import json",
            "",
            userCode,
            "",
            "# Test execution",
            "try:",
            "    result = \(functionName)(\(inputsStr))",
            "    print(json.dumps({",
            "        \"success\": True,",
            "        \"output\": str(result),",
            "        \"expected\": \"\(expectedOutput)\"",
            "    }))",
            "except Exception as e:",
            "    print(json.dumps({",
            "        \"success\": False,",
            "        \"error\": str(e)",
            "    }))",
            ""
        ].joined(separator: "\n")
    }
    
    private func parseTestResult(_ result: PythonExecutionResult, testCase: TestCase) -> TestResult {
        guard result.success,
              let data = result.output.data(using: .utf8),
              let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            return TestResult(
                testCase: testCase,
                passed: false,
                actualOutput: nil,
                error: result.error ?? "Failed to parse result"
            )
        }
        
        if let success = json["success"] as? Bool, success {
            let output = json["output"] as? String ?? ""
            let expected = json["expected"] as? String ?? ""
            let passed = output == expected
            
            return TestResult(
                testCase: testCase,
                passed: passed,
                actualOutput: output,
                error: passed ? nil : "Expected \(expected), got \(output)"
            )
        } else {
            return TestResult(
                testCase: testCase,
                passed: false,
                actualOutput: nil,
                error: json["error"] as? String ?? "Unknown error"
            )
        }
    }
    
    private func executeProcess(
        _ process: Process,
        outputPipe: Pipe,
        errorPipe: Pipe
    ) async throws -> (output: String, error: String?) {
        let maxLength = self.maxOutputLength
        return try await withCheckedThrowingContinuation { continuation in
            do {
                try process.run()
                process.waitUntilExit()
                
                let outputData = outputPipe.fileHandleForReading.readDataToEndOfFile()
                let errorData = errorPipe.fileHandleForReading.readDataToEndOfFile()
                
                let output = String(data: outputData, encoding: .utf8) ?? ""
                let errorOutput = String(data: errorData, encoding: .utf8)
                
                let trimmedOutput = String(output.prefix(maxLength))
                let error = errorOutput?.isEmpty == false ? errorOutput : nil
                
                continuation.resume(returning: (trimmedOutput, error))
            } catch {
                continuation.resume(throwing: error)
            }
        }
    }
    
    private func withTimeout<T>(
        seconds: TimeInterval,
        operation: @escaping () async throws -> T
    ) async throws -> T {
        try await withThrowingTaskGroup(of: T.self) { group in
            group.addTask {
                try await operation()
            }
            
            group.addTask {
                try await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
                throw PythonExecutionError.timeout
            }
            
            let result = try await group.next()!
            group.cancelAll()
            return result
        }
    }
}

struct TestResult: Identifiable {
    let id = UUID()
    let testCase: TestCase
    let passed: Bool
    let actualOutput: String?
    let error: String?
}
