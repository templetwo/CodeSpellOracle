import SwiftUI

// MARK: - Premium Cyberpunk Theme Extensions
extension Theme {
    struct NeonColors {
        let spellCasting = Color(hex: "00FFFF")      // Cyan
        let neonPink = Color(hex: "FF0080")
        let neonCyan = Color(hex: "00FFFF")
        let toxicGreen = Color(hex: "39FF14")
        let electricPurple = Color(hex: "9D00FF")
        let glitchRed = Color(hex: "FF0040")
        let cosmicBlue = Color(hex: "1E90FF")
        
        // Background layers
        let voidBlack = Color(hex: "0A0E27")
        let darkSpace = Color(hex: "0D1117")
        let deepPurple = Color(hex: "1A0B2E")
    }
    
    static let neon = NeonColors()
}

// MARK: - Glassmorphic Effect
struct GlassmorphicModifier: ViewModifier {
    let glowColor: Color
    let blurRadius: CGFloat
    let opacity: Double
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: Theme.radius.l)
                    .fill(Color.black.opacity(0.3))
                    .background(
                        RoundedRectangle(cornerRadius: Theme.radius.l)
                            .fill(.ultraThinMaterial)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.radius.l)
                            .stroke(glowColor.opacity(0.3), lineWidth: 1)
                            .shadow(color: glowColor.opacity(0.5), radius: 10)
                            .shadow(color: glowColor.opacity(0.3), radius: 20)
                    )
            )
    }
}

extension View {
    func glassmorphic(glowColor: Color = Theme.neon.neonCyan, blurRadius: CGFloat = 20, opacity: Double = 0.3) -> some View {
        modifier(GlassmorphicModifier(glowColor: glowColor, blurRadius: blurRadius, opacity: opacity))
    }
}

// MARK: - Neon Glow Effect
struct NeonGlowModifier: ViewModifier {
    let color: Color
    let intensity: Double
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.8 * intensity), radius: 4)
            .shadow(color: color.opacity(0.5 * intensity), radius: 8)
            .shadow(color: color.opacity(0.3 * intensity), radius: 16)
    }
}

extension View {
    func neonGlow(color: Color, intensity: Double = 1.0) -> some View {
        modifier(NeonGlowModifier(color: color, intensity: intensity))
    }
}

// MARK: - Pulsing Animation
struct PulsingModifier: ViewModifier {
    @State private var isPulsing = false
    let color: Color
    let duration: Double
    
    func body(content: Content) -> some View {
        content
            .scaleEffect(isPulsing ? 1.05 : 1.0)
            .opacity(isPulsing ? 1.0 : 0.8)
            .animation(
                Animation.easeInOut(duration: duration)
                    .repeatForever(autoreverses: true),
                value: isPulsing
            )
            .onAppear {
                isPulsing = true
            }
    }
}

extension View {
    func pulsing(color: Color = Theme.neon.neonCyan, duration: Double = 1.5) -> some View {
        modifier(PulsingModifier(color: color, duration: duration))
    }
}

// MARK: - Code Editor Style
struct CodeEditorStyle: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.type.mono)
            .padding(Theme.spacing.l)
            .background(
                RoundedRectangle(cornerRadius: Theme.radius.m)
                    .fill(Color.black.opacity(0.6))
                    .overlay(
                        RoundedRectangle(cornerRadius: Theme.radius.m)
                            .stroke(Theme.neon.toxicGreen.opacity(0.3), lineWidth: 1)
                    )
            )
            .neonGlow(color: Theme.neon.toxicGreen, intensity: 0.3)
    }
}

extension View {
    func codeEditorStyle() -> some View {
        modifier(CodeEditorStyle())
    }
}

// MARK: - Spell Cast Button Style
struct SpellCastButton: ButtonStyle {
    let color: Color
    @State private var isPressed = false
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Theme.type.heading)
            .foregroundColor(.white)
            .padding(.horizontal, Theme.spacing.xl)
            .padding(.vertical, Theme.spacing.m)
            .background(
                RoundedRectangle(cornerRadius: Theme.radius.m)
                    .fill(
                        LinearGradient(
                            colors: [color, color.opacity(0.7)],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: Theme.radius.m)
                    .stroke(color, lineWidth: 2)
            )
            .neonGlow(color: color, intensity: configuration.isPressed ? 1.5 : 1.0)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
            .animation(.spring(response: 0.3, dampingFraction: 0.6), value: configuration.isPressed)
    }
}

// MARK: - Cyberpunk HUD Overlay
struct CyberpunkHUD: View {
    let level: Int
    let spellsCompleted: Int
    let powerLevel: Double

    var body: some View {
        VStack {
            HStack(alignment: .top, spacing: 12) {
                // Level indicator - compact version
                HStack(spacing: 6) {
                    Text("LV")
                        .font(.system(size: 8, weight: .bold, design: .monospaced))
                        .foregroundColor(Theme.neon.neonCyan.opacity(0.7))
                    Text("\(level)")
                        .font(.system(size: 18, weight: .bold, design: .monospaced))
                        .foregroundColor(Theme.neon.neonCyan)
                        .neonGlow(color: Theme.neon.neonCyan, intensity: 0.6)
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black.opacity(0.4))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Theme.neon.neonCyan.opacity(0.3), lineWidth: 1)
                        )
                )

                Spacer()

                // Power meter - compact version
                VStack(alignment: .trailing, spacing: 3) {
                    Text("PWR")
                        .font(.system(size: 8, weight: .bold, design: .monospaced))
                        .foregroundColor(Theme.neon.toxicGreen.opacity(0.7))

                    HStack(spacing: 6) {
                        // Progress bar
                        GeometryReader { geometry in
                            ZStack(alignment: .leading) {
                                RoundedRectangle(cornerRadius: 3)
                                    .fill(Color.black.opacity(0.5))
                                    .frame(height: 6)

                                RoundedRectangle(cornerRadius: 3)
                                    .fill(
                                        LinearGradient(
                                            colors: [Theme.neon.toxicGreen, Theme.neon.neonCyan],
                                            startPoint: .leading,
                                            endPoint: .trailing
                                        )
                                    )
                                    .frame(width: geometry.size.width * powerLevel, height: 6)
                                    .neonGlow(color: Theme.neon.toxicGreen, intensity: 0.5)
                            }
                        }
                        .frame(width: 80, height: 6)

                        Text("\(Int(powerLevel * 100))%")
                            .font(.system(size: 12, weight: .bold, design: .monospaced))
                            .foregroundColor(Theme.neon.toxicGreen)
                    }
                }
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.black.opacity(0.4))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Theme.neon.toxicGreen.opacity(0.3), lineWidth: 1)
                        )
                )
            }
            .padding(.horizontal, 16)
            .padding(.top, 12)

            Spacer()
        }
        .allowsHitTesting(false) // Allow clicks to pass through
    }
}

// MARK: - Animated Background
struct AnimatedBackgroundView: View {
    @State private var phase: CGFloat = 0
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Base gradient
                LinearGradient(
                    colors: [
                        Theme.neon.voidBlack,
                        Theme.neon.darkSpace,
                        Theme.neon.deepPurple
                    ],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                // Animated grid
                Path { path in
                    let rows = 20
                    let cols = 20
                    let cellWidth = geometry.size.width / CGFloat(cols)
                    let cellHeight = geometry.size.height / CGFloat(rows)
                    
                    // Vertical lines
                    for i in 0...cols {
                        let x = CGFloat(i) * cellWidth
                        path.move(to: CGPoint(x: x, y: 0))
                        path.addLine(to: CGPoint(x: x, y: geometry.size.height))
                    }
                    
                    // Horizontal lines
                    for i in 0...rows {
                        let y = CGFloat(i) * cellHeight
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: geometry.size.width, y: y))
                    }
                }
                .stroke(
                    Theme.neon.neonCyan.opacity(0.1),
                    lineWidth: 1
                )
                .blur(radius: 0.5)
                
                // Floating particles
                ForEach(0..<10, id: \.self) { index in
                    Circle()
                        .fill(Theme.neon.neonCyan.opacity(0.3))
                        .frame(width: 4, height: 4)
                        .offset(
                            x: sin(phase + Double(index) * 0.5) * 200,
                            y: cos(phase + Double(index) * 0.3) * 150
                        )
                        .blur(radius: 2)
                }
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 20).repeatForever(autoreverses: false)) {
                phase = .pi * 2
            }
        }
    }
}

// MARK: - Spell Effect Overlay
struct SpellEffectOverlay: View {
    @Binding var isVisible: Bool
    let color: Color
    
    @State private var scale: CGFloat = 0.5
    @State private var opacity: Double = 0
    
    var body: some View {
        if isVisible {
            ZStack {
                Circle()
                    .fill(
                        RadialGradient(
                            colors: [color.opacity(0.6), color.opacity(0), .clear],
                            center: .center,
                            startRadius: 0,
                            endRadius: 300
                        )
                    )
                    .frame(width: 600, height: 600)
                    .scaleEffect(scale)
                    .opacity(opacity)
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)
            .onAppear {
                withAnimation(.easeOut(duration: 0.8)) {
                    scale = 1.5
                    opacity = 1.0
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    withAnimation(.easeOut(duration: 0.4)) {
                        opacity = 0
                    }
                }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    isVisible = false
                    scale = 0.5
                }
            }
        }
    }
}

// MARK: - Success Animation
struct SuccessParticleEffect: View {
    @Binding var isVisible: Bool
    @State private var particles: [ParticleData] = []
    
    struct ParticleData: Identifiable {
        let id = UUID()
        var position: CGPoint
        var velocity: CGPoint
        var scale: CGFloat
        var opacity: Double
    }
    
    var body: some View {
        if isVisible {
            ZStack {
                ForEach(particles) { particle in
                    Circle()
                        .fill(Theme.neon.toxicGreen)
                        .frame(width: 8 * particle.scale, height: 8 * particle.scale)
                        .position(particle.position)
                        .opacity(particle.opacity)
                        .neonGlow(color: Theme.neon.toxicGreen, intensity: 0.8)
                }
            }
            .ignoresSafeArea()
            .allowsHitTesting(false)
            .onAppear {
                createParticles()
                animateParticles()
            }
        }
    }
    
    private func createParticles() {
        particles = (0..<30).map { _ in
            ParticleData(
                position: CGPoint(x: 400, y: 300),
                velocity: CGPoint(
                    x: CGFloat.random(in: -5...5),
                    y: CGFloat.random(in: -8...8)
                ),
                scale: CGFloat.random(in: 0.5...1.5),
                opacity: 1.0
            )
        }
    }
    
    private func animateParticles() {
        Timer.scheduledTimer(withTimeInterval: 0.016, repeats: true) { timer in
            particles = particles.map { particle in
                var updated = particle
                updated.position.x += particle.velocity.x
                updated.position.y += particle.velocity.y
                updated.velocity.y += 0.2 // Gravity
                updated.opacity -= 0.02
                return updated
            }
            
            if particles.allSatisfy({ $0.opacity <= 0 }) {
                timer.invalidate()
                isVisible = false
            }
        }
    }
}
