import SwiftUI

// MARK: - Card Modifier
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(Theme.spacing.l)
            .background(Color.appSurface)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.radius.m)
                    .stroke(Color.appBorder, lineWidth: 1)
            )
            .cornerRadius(Theme.radius.m)
            .shadow(color: Color.black.opacity(0.25), radius: Theme.elevation.card, x: 0, y: 2)
    }
}

extension View {
    func card() -> some View { modifier(CardModifier()) }
}

// MARK: - Section Header
struct SectionHeader: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.type.heading)
            .foregroundColor(.primary)
            .padding(.vertical, Theme.spacing.s)
    }
}

extension View {
    func sectionHeader() -> some View { modifier(SectionHeader()) }
}

// MARK: - Code Block
struct CodeBlock: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(Theme.type.mono)
            .padding(Theme.spacing.l)
            .background(Color(NSColor.textBackgroundColor))
            .overlay(
                RoundedRectangle(cornerRadius: Theme.radius.s)
                    .stroke(Color.appBorder, lineWidth: 1)
            )
            .cornerRadius(Theme.radius.s)
    }
}

extension View {
    func codeBlock() -> some View { modifier(CodeBlock()) }
}

// MARK: - Panel Background
struct PanelBackground: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background(Color.appSurface)
    }
}

extension View {
    func panelBackground() -> some View { modifier(PanelBackground()) }
}

// MARK: - Tag/Pill
struct TagModifier: ViewModifier {
    let color: Color
    func body(content: Content) -> some View {
        content
            .font(.caption2)
            .padding(.horizontal, Theme.spacing.s)
            .padding(.vertical, Theme.spacing.xs)
            .background(color.opacity(0.15))
            .foregroundColor(color)
            .cornerRadius(6)
    }
}

extension View {
    func tagStyle(_ color: Color) -> some View { modifier(TagModifier(color: color)) }
}
