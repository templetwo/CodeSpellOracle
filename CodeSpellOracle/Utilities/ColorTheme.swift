import SwiftUI

struct ColorTheme {
    // MARK: - Neon Colors
    static let neonCyan = Color(hex: "00FFFF")
    static let neonMagenta = Color(hex: "FF00FF")
    static let toxicGreen = Color(hex: "39FF14")
    static let electricPurple = Color(hex: "9D00FF")
    static let glitchRed = Color(hex: "FF0040")
    
    // MARK: - Background Colors
    static let voidBlack = Color(hex: "0A0E27")
    static let darkSpace = Color(hex: "0D1117")
    static let deepPurple = Color(hex: "1A0B2E")
    
    // MARK: - Wizard Rank Colors
    static func rankColor(for rank: WizardRank) -> Color {
        switch rank {
        case .apprentice:
            return Color.blue
        case .scholar:
            return Color.purple
        case .enchanter:
            return toxicGreen
        case .masterSorcerer:
            return Color.orange
        case .archmage:
            return Color.yellow
        }
    }
    
    // MARK: - Gradient Definitions
    static let neonGradient = LinearGradient(
        colors: [neonCyan, neonMagenta, electricPurple],
        startPoint: .topLeading,
        endPoint: .bottomTrailing
    )
    
    static let spaceGradient = LinearGradient(
        colors: [voidBlack, darkSpace, deepPurple],
        startPoint: .top,
        endPoint: .bottom
    )
    
    // MARK: - Glow Effects
    static func glowEffect(color: Color, radius: CGFloat = 10) -> some View {
        color
            .shadow(color: color.opacity(0.8), radius: radius)
            .shadow(color: color.opacity(0.5), radius: radius * 2)
            .shadow(color: color.opacity(0.3), radius: radius * 3)
    }
}

// MARK: - Color Extension for Hex
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
