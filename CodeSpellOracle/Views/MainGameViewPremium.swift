import SwiftUI

struct MainGameViewPremium: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var windowManager: WindowManager
    @State private var code: String = ""
    @State private var testResults: [TestResult] = []
    @State private var isRunning = false
    @State private var showHint = false
    @State private var hintIndex = 0
    @State private var showToast = false
    @State private var toastConfig = ToastConfig(style: .info, message: "")
    @State private var showSpellEffect = false
    @State private var showSuccessParticles = false
    
    var body: some View {
        ZStack {
            // Animated background
            AnimatedBackgroundView()
            
            // Main content
            HStack(spacing: 0) {
                // LEFT PANEL: Level Info & Hints
                PremiumLeftPanel(
                    level: gameState.currentLevel,
                    showHint: $showHint,
                    hintIndex: $hintIndex
                )
                .frame(width: 320)
                .glassmorphic(glowColor: Theme.neon.neonCyan)
                
                Divider()
                    .overlay(Theme.neon.neonCyan.opacity(0.3))
                
                // CENTER PANEL: Code Editor
                VStack(spacing: 0) {
                    PremiumCodeEditorPanel(code: $code)
                    
                    Divider()
                        .overlay(Theme.neon.toxicGreen.opacity(0.3))
                    
                    // Action Bar with premium styling
                    HStack(spacing: Theme.spacing.l) {
                        Button(action: runCode) {
                            HStack(spacing: Theme.spacing.s) {
                                Image(systemName: "play.fill")
                                Text("Cast Spell")
                            }
                        }
                        .keyboardShortcut("r", modifiers: .command)
                        .disabled(isRunning || gameState.currentLevel == nil)
                        .buttonStyle(SpellCastButton(color: Theme.neon.spellCasting))
                        
                        Button(action: requestHint) {
                            HStack(spacing: Theme.spacing.s) {
                                Image(systemName: "lightbulb.fill")
                                Text("Oracle Wisdom")
                            }
                        }
                        .keyboardShortcut("h", modifiers: .command)
                        .disabled(gameState.currentLevel == nil)
                        .buttonStyle(SpellCastButton(color: Theme.neon.electricPurple))
                        
                        Spacer()
                        
                        if isRunning {
                            HStack(spacing: Theme.spacing.s) {
                                ProgressView()
                                    .scaleEffect(0.8)
                                Text("Channeling...")
                                    .font(.system(.caption, design: .monospaced))
                                    .foregroundColor(Theme.neon.neonCyan)
                            }
                            .pulsing(color: Theme.neon.neonCyan)
                        }
                    }
                    .padding(Theme.spacing.l)
                    .background(
                        Color.black.opacity(0.5)
                            .overlay(
                                LinearGradient(
                                    colors: [Theme.neon.neonCyan.opacity(0.1), .clear],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                    )
                }
                
                Divider()
                    .overlay(Theme.neon.toxicGreen.opacity(0.3))
                
                // RIGHT PANEL: Test Results
                PremiumRightPanel(testResults: testResults)
                    .frame(width: 320)
                    .glassmorphic(glowColor: Theme.neon.toxicGreen)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            
            // HUD Overlay
            if let level = gameState.currentLevel {
                CyberpunkHUD(
                    level: level.number,
                    spellsCompleted: testResults.filter { $0.passed }.count,
                    powerLevel: testResults.isEmpty ? 0 : Double(testResults.filter { $0.passed }.count) / Double(testResults.count)
                )
            }
            
            // Spell casting effect
            SpellEffectOverlay(isVisible: $showSpellEffect, color: Theme.neon.neonCyan)
            
            // Success particles
            SuccessParticleEffect(isVisible: $showSuccessParticles)
            
            // Welcome overlay
            if gameState.currentLevel == nil {
                PremiumWelcomeOverlay()
            }
        }
        .toast(isPresented: $showToast, toastConfig)
    }
    
    private func runCode() {
        isRunning = true
        testResults = []
        showSpellEffect = true
        
        Task {
            let results = await gameState.submitCode(code)
            await MainActor.run {
                testResults = results
                isRunning = false
                let allPass = results.allSatisfy { $0.passed }
                
                if allPass {
                    showSuccessParticles = true
                }
                
                toastConfig = ToastConfig(
                    style: allPass ? .success : .error,
                    message: allPass ? "✨ Spell successfully cast!" : "⚠️ Spell casting failed"
                )
                showToast = true
                HapticsService.shared.play(allPass ? .success : .error)
            }
        }
    }
    
    private func requestHint() {
        guard let level = gameState.currentLevel else { return }
        if hintIndex < level.hints.count {
            showHint = true
            HapticsService.shared.play(.selection)
        }
    }
}

// MARK: - Premium Left Panel
struct PremiumLeftPanel: View {
    let level: Level?
    @Binding var showHint: Bool
    @Binding var hintIndex: Int
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.spacing.l) {
                if let level = level {
                    // Level Header with neon styling
                    VStack(alignment: .leading, spacing: Theme.spacing.s) {
                        HStack {
                            Text("LEVEL \(level.number)")
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                                .foregroundColor(Theme.neon.neonCyan)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 4)
                                .background(Theme.neon.neonCyan.opacity(0.2))
                                .cornerRadius(4)
                                .neonGlow(color: Theme.neon.neonCyan, intensity: 0.5)
                            
                            Text(level.difficultyStars)
                                .font(.caption)
                        }
                        
                        Text(level.title)
                            .font(Theme.type.heading)
                            .foregroundColor(Theme.neon.neonCyan)
                            .neonGlow(color: Theme.neon.neonCyan, intensity: 0.3)
                    }
                    
                    Divider()
                        .overlay(Theme.neon.neonCyan.opacity(0.3))
                    
                    // Story with mystical styling
                    VStack(alignment: .leading, spacing: Theme.spacing.s) {
                        Label {
                            Text("ANCIENT SCROLL")
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                        } icon: {
                            Image(systemName: "scroll.fill")
                        }
                        .foregroundColor(Theme.neon.electricPurple)
                        
                        Text(level.story)
                            .font(Theme.type.caption)
                            .foregroundColor(Theme.colors.textSecondary)
                            .padding(Theme.spacing.m)
                            .background(
                                RoundedRectangle(cornerRadius: Theme.radius.s)
                                    .fill(Color.black.opacity(0.4))
                                    .overlay(
                                        RoundedRectangle(cornerRadius: Theme.radius.s)
                                            .stroke(Theme.neon.electricPurple.opacity(0.3), lineWidth: 1)
                                    )
                            )
                    }
                    
                    // Oracle Quote with glow
                    PremiumQuoteBox(text: level.oracleSays)
                    
                    Divider()
                        .overlay(Theme.neon.toxicGreen.opacity(0.3))
                    
                    // Task
                    VStack(alignment: .leading, spacing: Theme.spacing.s) {
                        Label {
                            Text("SPELL OBJECTIVE")
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                        } icon: {
                            Image(systemName: "target")
                        }
                        .foregroundColor(Theme.neon.glitchRed)
                        
                        Text(level.description)
                            .font(Theme.type.caption)
                            .foregroundColor(Theme.colors.textPrimary)
                    }
                    
                    // Example with code styling
                    VStack(alignment: .leading, spacing: Theme.spacing.s) {
                        Label {
                            Text("INCANTATION EXAMPLE")
                                .font(.system(size: 10, weight: .bold, design: .monospaced))
                        } icon: {
                            Image(systemName: "sparkles")
                        }
                        .foregroundColor(Theme.neon.toxicGreen)
                        
                        Text(level.example)
                            .font(.system(.caption2, design: .monospaced))
                            .foregroundColor(Theme.neon.toxicGreen)
                            .padding(Theme.spacing.m)
                            .codeEditorStyle()
                    }
                    
                    // Hints with animation
                    if showHint && hintIndex < level.hints.count {
                        VStack(alignment: .leading, spacing: Theme.spacing.s) {
                            Label {
                                Text("ORACLE'S WISDOM")
                                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                            } icon: {
                                Image(systemName: "lightbulb.fill")
                            }
                            .foregroundColor(Theme.neon.cosmicBlue)
                            
                            Text(level.hints[hintIndex])
                                .font(Theme.type.caption)
                                .foregroundColor(.white)
                                .padding(Theme.spacing.m)
                                .background(
                                    RoundedRectangle(cornerRadius: Theme.radius.s)
                                        .fill(Theme.neon.cosmicBlue.opacity(0.2))
                                        .overlay(
                                            RoundedRectangle(cornerRadius: Theme.radius.s)
                                                .stroke(Theme.neon.cosmicBlue, lineWidth: 1)
                                        )
                                )
                                .neonGlow(color: Theme.neon.cosmicBlue, intensity: 0.6)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                } else {
                    VStack(spacing: Theme.spacing.l) {
                        Image(systemName: "sparkles")
                            .font(.system(size: 48))
                            .foregroundColor(Theme.neon.neonCyan)
                            .pulsing(color: Theme.neon.neonCyan)
                        
                        Text("Awaiting your command...")
                            .font(Theme.type.heading)
                            .foregroundColor(Theme.neon.neonCyan)
                            .neonGlow(color: Theme.neon.neonCyan, intensity: 0.5)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
            .padding(Theme.spacing.l)
        }
    }
}

// MARK: - Premium Code Editor Panel
struct PremiumCodeEditorPanel: View {
    @Binding var code: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.spacing.s) {
            HStack {
                Text("SPELL CODEX")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(Theme.neon.toxicGreen)
                
                Spacer()
                
                Text("⌘R to cast")
                    .font(.system(size: 9, design: .monospaced))
                    .foregroundColor(Theme.colors.textMuted)
            }
            .padding(.horizontal, Theme.spacing.l)
            .padding(.top, Theme.spacing.m)
            
            TextEditor(text: $code)
                .font(Theme.type.mono)
                .foregroundColor(Theme.neon.toxicGreen)
                .scrollContentBackground(.hidden)
                .background(Color.black.opacity(0.6))
                .padding(Theme.spacing.l)
        }
        .background(
            RoundedRectangle(cornerRadius: Theme.radius.l)
                .fill(Color.black.opacity(0.3))
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.radius.l)
                        .stroke(Theme.neon.toxicGreen.opacity(0.3), lineWidth: 1)
                )
        )
        .padding(Theme.spacing.l)
    }
}

// MARK: - Premium Right Panel
struct PremiumRightPanel: View {
    let testResults: [TestResult]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: Theme.spacing.l) {
                Text("SPELL RESULTS")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
                    .foregroundColor(Theme.neon.toxicGreen)
                
                if testResults.isEmpty {
                    VStack(spacing: Theme.spacing.m) {
                        Image(systemName: "wand.and.stars")
                            .font(.system(size: 36))
                            .foregroundColor(Theme.neon.toxicGreen.opacity(0.5))
                        
                        Text("No results yet")
                            .font(Theme.type.caption)
                            .foregroundColor(Theme.colors.textSecondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(Theme.spacing.xl)
                } else {
                    ForEach(Array(testResults.enumerated()), id: \.offset) { index, result in
                        PremiumTestResultCard(result: result, index: index)
                    }
                }
            }
            .padding(Theme.spacing.l)
        }
    }
}

// MARK: - Premium Test Result Card
struct PremiumTestResultCard: View {
    let result: TestResult
    let index: Int

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.spacing.s) {
            HStack {
                Image(systemName: result.passed ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(result.passed ? Theme.neon.toxicGreen : Theme.neon.glitchRed)
                    .neonGlow(color: result.passed ? Theme.neon.toxicGreen : Theme.neon.glitchRed, intensity: 0.8)

                Text("Test \(index + 1)")
                    .font(.system(.caption, design: .monospaced))
                    .foregroundColor(Theme.colors.textPrimary)

                Spacer()

                Text(result.passed ? "PASS" : "FAIL")
                    .font(.system(size: 9, weight: .bold, design: .monospaced))
                    .foregroundColor(result.passed ? Theme.neon.toxicGreen : Theme.neon.glitchRed)
            }

            // Show mystical error if available, otherwise fallback to raw error
            if let mysticalError = result.mysticalError {
                MysticalErrorView(error: mysticalError)
                    .padding(.top, Theme.spacing.s)
            } else if let error = result.error {
                Text(error)
                    .font(.system(.caption2, design: .monospaced))
                    .foregroundColor(Theme.neon.glitchRed)
                    .padding(Theme.spacing.s)
                    .background(
                        RoundedRectangle(cornerRadius: Theme.radius.s)
                            .fill(Theme.neon.glitchRed.opacity(0.1))
                    )
            }
        }
        .padding(Theme.spacing.m)
        .background(
            RoundedRectangle(cornerRadius: Theme.radius.m)
                .fill(Color.black.opacity(0.4))
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.radius.m)
                        .stroke(
                            result.passed ? Theme.neon.toxicGreen.opacity(0.3) : Theme.neon.glitchRed.opacity(0.3),
                            lineWidth: 1
                        )
                )
        )
    }
}

// MARK: - Premium Quote Box
struct PremiumQuoteBox: View {
    let text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: Theme.spacing.s) {
            Label {
                Text("THE ORACLE SPEAKS")
                    .font(.system(size: 10, weight: .bold, design: .monospaced))
            } icon: {
                Image(systemName: "person.fill.questionmark")
            }
            .foregroundColor(Theme.neon.neonPink)
            
            Text(text)
                .font(.system(.caption, design: .serif))
                .italic()
                .foregroundColor(Theme.colors.textPrimary)
                .padding(Theme.spacing.m)
                .background(
                    RoundedRectangle(cornerRadius: Theme.radius.s)
                        .fill(Theme.neon.neonPink.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: Theme.radius.s)
                                .stroke(Theme.neon.neonPink.opacity(0.3), lineWidth: 1)
                        )
                )
                .neonGlow(color: Theme.neon.neonPink, intensity: 0.3)
        }
    }
}

// MARK: - Premium Welcome Overlay
struct PremiumWelcomeOverlay: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.7)
                .ignoresSafeArea()
            
            VStack(spacing: Theme.spacing.xl) {
                Text("✨ CODE SPELL ORACLE ✨")
                    .font(.system(size: 32, weight: .bold, design: .monospaced))
                    .foregroundColor(Theme.neon.neonCyan)
                    .neonGlow(color: Theme.neon.neonCyan, intensity: 1.0)
                    .pulsing(color: Theme.neon.neonCyan, duration: 2.0)
                
                Text("Master Python through mystical incantations")
                    .font(.system(.title3, design: .rounded))
                    .foregroundColor(Theme.colors.textSecondary)
                
                Text("Press ⌘L to begin your journey")
                    .font(.system(.body, design: .monospaced))
                    .foregroundColor(Theme.neon.toxicGreen)
                    .padding(Theme.spacing.l)
                    .glassmorphic(glowColor: Theme.neon.toxicGreen)
            }
            .padding(Theme.spacing.xxxl)
        }
    }
}
