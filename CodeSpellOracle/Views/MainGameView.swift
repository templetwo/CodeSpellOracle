import SwiftUI

struct MainGameView: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var windowManager: WindowManager
    @State private var code: String = ""
    @State private var testResults: [TestResult] = []
    @State private var isRunning = false
    @State private var showHint = false
    @State private var hintIndex = 0
    @State private var showToast = false
    @State private var toastConfig = ToastConfig(style: .info, message: "")
    
    var body: some View {
        HStack(spacing: 0) {
            // LEFT PANEL: Level Info & Hints
            LeftPanel(
                level: gameState.currentLevel,
                showHint: $showHint,
                hintIndex: $hintIndex
            )
            .frame(width: 280)
            .panelBackground()
            
            Divider()
            
            // CENTER PANEL: Code Editor
            VStack(spacing: 0) {
                CodeEditorPanel(code: $code)
                
                Divider()
                
                // Action Bar
                HStack {
                    Button(action: runCode) {
                        Label("Run Code", systemImage: "play.fill")
                    }
                    .keyboardShortcut("r", modifiers: .command)
                    .disabled(isRunning || gameState.currentLevel == nil)
                    .buttonStyle(PrimaryButtonStyle())
                    
                    Button(action: requestHint) {
                        Label("Hint", systemImage: "lightbulb")
                    }
                    .keyboardShortcut("h", modifiers: .command)
                    .disabled(gameState.currentLevel == nil)
                    .buttonStyle(SecondaryButtonStyle())
                    
                    Spacer()
                    
                    if isRunning {
                        ProgressView()
                            .scaleEffect(0.7)
                    }
                }
                .padding()
                .background(Color(nsColor: .controlBackgroundColor))
            }
            
            Divider()
            
            // RIGHT PANEL: Test Results
            RightPanel(testResults: testResults)
                .frame(width: 280)
                .panelBackground()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(alignment: .top) {
            if gameState.currentLevel == nil {
                WelcomeOverlay()
            }
        }
        .toast(isPresented: $showToast, toastConfig)
    }
    
    private func runCode() {
        isRunning = true
        testResults = []
        
        Task {
            let results = await gameState.submitCode(code)
            await MainActor.run {
                testResults = results
                isRunning = false
                let allPass = results.allSatisfy { $0.passed }
                toastConfig = ToastConfig(style: allPass ? .success : .error,
                                          message: allPass ? "All tests passed!" : "Some tests failed")
                showToast = true
                HapticsService.shared.play(allPass ? .success : .error)
            }
        }
    }
    
    private func requestHint() {
        guard let level = gameState.currentLevel else { return }
        if hintIndex < level.hints.count {
            showHint = true
        }
    }
}

// MARK: - Left Panel
struct LeftPanel: View {
    let level: Level?
    @Binding var showHint: Bool
    @Binding var hintIndex: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                if let level = level {
                    // Level Header
                    VStack(alignment: .leading, spacing: 4) {
                        HStack {
                            Text("Level \(level.number)")
                                .font(.caption2)
                                .foregroundColor(.secondary)
                                .padding(.horizontal, 6)
                                .padding(.vertical, 2)
                                .background(Color.purple.opacity(0.2))
                                .cornerRadius(4)
                            
                            Text(level.difficultyStars)
                                .font(.caption)
                        }
                        
                        Text(level.title)
                            .font(.headline)
                            .bold()
                            .foregroundColor(.purple)
                    }
                    
                    Divider().padding(.vertical, 4)
                    
                    // Story
                    VStack(alignment: .leading, spacing: 6) {
                        Label("Story", systemImage: "book.fill")
                            .font(.caption)
                            .foregroundColor(.blue)
                        
                        Text(level.story)
                            .font(.caption)
                            .foregroundColor(.secondary)
                            .lineLimit(3)
                    }
                    
                    // Oracle Quote
                    QuoteBox(text: level.oracleSays)
                    
                    Divider().padding(.vertical, 4)
                    
                    // Task
                    VStack(alignment: .leading, spacing: 6) {
                        Label("Task", systemImage: "target")
                            .font(.caption)
                            .foregroundColor(.orange)
                        
                        Text(level.description)
                            .font(.caption)
                    }
                    
                    // Example
                    VStack(alignment: .leading, spacing: 6) {
                        Label("Example", systemImage: "doc.text.fill")
                            .font(.caption)
                            .foregroundColor(.green)
                        
                        Text(level.example)
                            .font(.system(.caption2, design: .monospaced))
                            .padding(8)
                            .background(Color.black.opacity(0.7))
                            .foregroundColor(.green)
                            .cornerRadius(6)
                    }
                    
                    // Hints
                    if showHint && hintIndex < level.hints.count {
                        VStack(alignment: .leading, spacing: 6) {
                            Label("💡 Hint", systemImage: "lightbulb.fill")
                                .font(.caption)
                                .foregroundColor(.yellow)
                            
                            Text(level.hints[hintIndex])
                                .font(.caption)
                                .padding(8)
                                .background(Color.yellow.opacity(0.15))
                                .cornerRadius(6)
                                .shadow(color: .yellow.opacity(0.3), radius: 4)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                } else {
                    Text("Select a level to begin")
                        .font(.title3)
                        .foregroundColor(.secondary)
                }
            }
            .padding(12)
        }
    }
}

// MARK: - Code Editor Panel
struct CodeEditorPanel: View {
    @Binding var code: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // Header
            HStack {
                Label("Python Code", systemImage: "chevron.left.forwardslash.chevron.right")
                    .font(.headline)
                Spacer()
                Text("Press ⌘R to run")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .background(Color(nsColor: .controlBackgroundColor))
            
            // Code editor with placeholder
            ZStack(alignment: .topLeading) {
                if code.isEmpty {
                    Text("Type your Python code here...\nPress ⌘R when ready to run")
                        .font(.system(.body, design: .monospaced))
                        .foregroundColor(.secondary)
                        .padding(12)
                }
                
                TextEditor(text: $code)
                    .font(.system(.callout, design: .monospaced))
                    .padding(8)
                    .opacity(code.isEmpty ? 0.5 : 1.0)
                    .scrollContentBackground(.hidden)
                    .background(Color(nsColor: .textBackgroundColor))
            }
        }
    }
}

// MARK: - Right Panel
struct RightPanel: View {
    let testResults: [TestResult]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 12) {
                Label("Test Results", systemImage: "checkmark.circle.fill")
                    .font(.caption)
                    .foregroundColor(.cyan)
                
                if testResults.isEmpty {
                    Text("Run code to see results")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    ForEach(testResults) { result in
                        TestResultCard(result: result)
                    }
                }
            }
            .padding(12)
        }
    }
}

// MARK: - Components
struct QuoteBox: View {
    let text: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 6) {
            Image(systemName: "sparkles")
                .foregroundColor(.purple)
                .font(.caption)
            Text(text)
                .font(.caption)
                .italic()
                .foregroundColor(.purple)
        }
        .padding(8)
        .background(
            LinearGradient(
                colors: [Color.purple.opacity(0.15), Color.blue.opacity(0.1)],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(Color.purple.opacity(0.3), lineWidth: 1)
        )
    }
}

struct TestResultCard: View {
    let result: TestResult
    
    var body: some View {
        HStack(spacing: 8) {
            Image(systemName: result.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                .foregroundColor(result.passed ? .green : .red)
                .font(.caption)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(result.testCase.inputs.joined(separator: ", "))
                    .font(.caption2)
                    .bold()
                
                if let output = result.actualOutput {
                    Text("→ \(output)")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                }
                
                if let error = result.error {
                    Text(error)
                        .font(.caption2)
                        .foregroundColor(.red)
                        .lineLimit(2)
                }
            }
            
            Spacer()
        }
        .padding(8)
        .background(result.passed ? Color.green.opacity(0.1) : Color.red.opacity(0.1))
        .cornerRadius(6)
        .overlay(
            RoundedRectangle(cornerRadius: 6)
                .stroke(result.passed ? Color.green.opacity(0.3) : Color.red.opacity(0.3), lineWidth: 1)
        )
    }
}

struct WelcomeOverlay: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("🧙‍♂️")
                .font(.system(size: 80))
            
            Text("Code Spell Oracle")
                .font(.largeTitle)
                .bold()
            
            Text("Select a level from the menu to begin your magical journey")
                .foregroundColor(.secondary)
            
            Text("⌘⇧L - Level Selection")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .padding(40)
        .background(.ultraThinMaterial)
        .cornerRadius(16)
        .shadow(radius: 20)
    }
}
