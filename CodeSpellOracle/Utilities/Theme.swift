import SwiftUI

// Unified design system tokens
struct Theme {
    struct Colors {
        let primary = Color(hex: "00D1FF")
        let secondary = Color(hex: "9D00FF")
        let accent = Color(hex: "39FF14")
        let background = Color(NSColor.windowBackgroundColor)
        let surface = Color(NSColor.controlBackgroundColor)
        let surfaceElevated = Color(hex: "131826")
        let border = Color.white.opacity(0.08)
        let textPrimary = Color.white.opacity(0.95)
        let textSecondary = Color.white.opacity(0.7)
        let textMuted = Color.white.opacity(0.5)
        let success = Color.green
        let warning = Color.orange
        let danger = Color.red
        let info = Color.cyan
    }
    
    struct Typography {
        let title = Font.system(size: 24, weight: .bold)
        let heading = Font.system(size: 17, weight: .semibold)
        let body = Font.system(size: 13, weight: .regular)
        let caption = Font.system(size: 11, weight: .regular)
        let mono = Font.system(.body, design: .monospaced)
    }
    
    struct Spacing {
        let xs: CGFloat = 4
        let s: CGFloat = 8
        let m: CGFloat = 12
        let l: CGFloat = 16
        let xl: CGFloat = 24
        let xxl: CGFloat = 32
        let xxxl: CGFloat = 40
    }
    
    struct Radius {
        let s: CGFloat = 6
        let m: CGFloat = 10
        let l: CGFloat = 14
    }
    
    struct Elevation {
        let none: CGFloat = 0
        let card: CGFloat = 6
        let popover: CGFloat = 10
        let modal: CGFloat = 16
    }
    
    static let colors = Colors()
    static let type = Typography()
    static let spacing = Spacing()
    static let radius = Radius()
    static let elevation = Elevation()
}

// MARK: - Convenience color aliases
extension Color {
    static var appBackground: Color { Theme.colors.background }
    static var appSurface: Color { Theme.colors.surface }
    static var appSurfaceElevated: Color { Theme.colors.surfaceElevated }
    static var appBorder: Color { Theme.colors.border }
    static var appPrimary: Color { Theme.colors.primary }
    static var appSecondary: Color { Theme.colors.secondary }
    static var appAccent: Color { Theme.colors.accent }
    static var appSuccess: Color { Theme.colors.success }
    static var appWarning: Color { Theme.colors.warning }
    static var appDanger: Color { Theme.colors.danger }
    static var appInfo: Color { Theme.colors.info }
}
