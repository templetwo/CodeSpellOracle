import SwiftUI

struct AnimationHelpers {
    // MARK: - Standard Animations
    static let smooth = Animation.easeInOut(duration: 0.3)
    static let bouncy = Animation.spring(response: 0.5, dampingFraction: 0.7)
    static let quick = Animation.easeOut(duration: 0.15)
    static let slow = Animation.easeInOut(duration: 0.6)
    
    // MARK: - Special Effects
    static let glitch = Animation.linear(duration: 0.1).repeatCount(3, autoreverses: true)
    static let pulse = Animation.easeInOut(duration: 1.0).repeatForever(autoreverses: true)
    static let float = Animation.easeInOut(duration: 2.0).repeatForever(autoreverses: true)
}

// MARK: - View Modifiers

struct ShakeEffect: GeometryEffect {
    var amount: CGFloat = 10
    var shakesPerUnit = 3
    var animatableData: CGFloat
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(
            CGAffineTransform(
                translationX: amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
                y: 0
            )
        )
    }
}

extension View {
    func shake(trigger: Int) -> some View {
        modifier(ShakeEffect(animatableData: CGFloat(trigger)))
    }
}

// MARK: - Particle Effect View (Stub)

struct ParticleEffect: View {
    let type: ParticleType
    
    enum ParticleType {
        case success
        case error
        case spell
        case mana
    }
    
    var body: some View {
        // TODO: Implement actual particle system using SpriteKit
        // For now, simple emoji-based particles
        Group {
            switch type {
            case .success:
                Text("✨")
                    .font(.system(size: 30))
                    .opacity(0)
                    .animation(.easeOut(duration: 1.0), value: UUID())
            case .error:
                Text("💥")
                    .font(.system(size: 30))
                    .opacity(0)
                    .animation(.easeOut(duration: 0.5), value: UUID())
            case .spell:
                Text("🔮")
                    .font(.system(size: 40))
                    .opacity(0)
                    .animation(.easeInOut(duration: 1.5), value: UUID())
            case .mana:
                Text("⚡")
                    .font(.system(size: 25))
                    .opacity(0)
                    .animation(.easeOut(duration: 0.8), value: UUID())
            }
        }
    }
}

// MARK: - Glow Modifier

struct GlowModifier: ViewModifier {
    let color: Color
    let radius: CGFloat
    
    func body(content: Content) -> some View {
        content
            .shadow(color: color.opacity(0.8), radius: radius)
            .shadow(color: color.opacity(0.5), radius: radius * 2)
            .shadow(color: color.opacity(0.3), radius: radius * 3)
    }
}

extension View {
    func neonGlow(color: Color = ColorTheme.neonCyan, radius: CGFloat = 10) -> some View {
        modifier(GlowModifier(color: color, radius: radius))
    }
}

// MARK: - Typewriter Effect

struct TypewriterText: View {
    let text: String
    let speed: Double
    
    @State private var displayedText = ""
    
    var body: some View {
        Text(displayedText)
            .onAppear {
                animateText()
            }
    }
    
    private func animateText() {
        for (index, character) in text.enumerated() {
            DispatchQueue.main.asyncAfter(deadline: .now() + speed * Double(index)) {
                displayedText.append(character)
            }
        }
    }
}

// MARK: - Shimmer Effect

struct ShimmerModifier: ViewModifier {
    @State private var phase: CGFloat = 0
    
    func body(content: Content) -> some View {
        content
            .overlay(
                LinearGradient(
                    colors: [.clear, .white.opacity(0.3), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .offset(x: phase)
                .mask(content)
            )
            .onAppear {
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    phase = 300
                }
            }
    }
}

extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}
