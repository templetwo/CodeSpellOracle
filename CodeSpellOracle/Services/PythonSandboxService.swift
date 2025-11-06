import Foundation

class PythonSandboxService {
    static let shared = PythonSandboxService()
    
    private let pythonPath = "/usr/bin/python3" // Assume system Python
    private let timeout: TimeInterval = 5.0 // 5 second timeout for execution
    
    init() {}
    
    /// Executes the given Python code and returns the output or error
    func execute(code: String, testInput: String? = nil) async -> (output: String, error: String?) {
        await withCheckedContinuation { continuation in
            let task = Process()
            task.executableURL = URL(fileURLWithPath: pythonPath)
            
            let pipe = Pipe()
            task.standardOutput = pipe
            let errorPipe = Pipe()
            task.standardError = errorPipe
            
            // Create temporary file for code
            let tempDir = FileManager.default.temporaryDirectory
            let codeFileURL = tempDir.appendingPathComponent(UUID().uuidString + ".py")
            
            do {
                try code.write(to: codeFileURL, atomically: true, encoding: .utf8)
            } catch {
                continuation.resume(returning: ("", "Failed to write code file: \(error)"))
                return
            }
            
            task.arguments = [codeFileURL.path]
            
            // Handle input if provided
            if let input = testInput {
                let inputPipe = Pipe()
                task.standardInput = inputPipe
                if let data = input.data(using: .utf8) {
                    try? inputPipe.fileHandleForWriting.write(contentsOf: data)
                    try? inputPipe.fileHandleForWriting.close()
                }
            }
            
            // Timeout timer
            let timer = DispatchSource.makeTimerSource()
            timer.schedule(deadline: .now() + timeout)
            timer.setEventHandler {
                task.terminate()
            }
            timer.resume()
            
            task.terminationHandler = { _ in
                timer.cancel()
                
                let output = String(data: pipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
                let errorOutput = String(data: errorPipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
                
                // Clean up temp file
                try? FileManager.default.removeItem(at: codeFileURL)
                
                continuation.resume(returning: (output.trimmingCharacters(in: .whitespacesAndNewlines), errorOutput.isEmpty ? nil : errorOutput))
            }
            
            do {
                try task.run()
            } catch {
                continuation.resume(returning: ("", "Failed to run Python process: \(error)"))
            }
        }
    }
    
    /// Tests a function against multiple test cases
    func testFunction(code: String, functionName: String, testCases: [TestCase]) async throws -> [TestResult] {
        var results: [TestResult] = []
        
        for testCase in testCases {
            // Build complete test code: user's function + function call with test inputs
            let args = testCase.inputs.map { "\"\($0)\"" }.joined(separator: ", ")
            let testCode = """
\(code)

# Test call
result = \(functionName)(\(args))
print(result)
"""
            
            let (output, error) = await execute(code: testCode)
            
            if let error = error {
                let mysticalError = MysticalErrorHandler.translate(error, code: code)
                results.append(TestResult(
                    testCase: testCase,
                    passed: false,
                    actualOutput: nil,
                    error: error,
                    mysticalError: mysticalError
                ))
            } else {
                let passed = output.trimmingCharacters(in: .whitespacesAndNewlines) == testCase.expectedOutput.trimmingCharacters(in: .whitespacesAndNewlines)
                results.append(TestResult(
                    testCase: testCase,
                    passed: passed,
                    actualOutput: output,
                    error: nil,
                    mysticalError: nil
                ))
            }
        }
        
        return results
    }
}

// Used by GameState and views for Level test cases
struct TestResult {
    let testCase: TestCase
    let passed: Bool
    let actualOutput: String?
    let error: String?
    let mysticalError: MysticalError?
}
