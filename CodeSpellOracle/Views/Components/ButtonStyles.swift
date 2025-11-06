import SwiftUI

// MARK: - Primary Button
struct PrimaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14, weight: .semibold))
            .padding(.horizontal, Theme.spacing.xl)
            .padding(.vertical, Theme.spacing.s)
            .background(Color.appPrimary)
            .foregroundColor(.black)
            .cornerRadius(Theme.radius.m)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .opacity(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

// MARK: - Secondary Button
struct SecondaryButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14, weight: .semibold))
            .padding(.horizontal, Theme.spacing.xl)
            .padding(.vertical, Theme.spacing.s)
            .background(Color.appSecondary.opacity(0.15))
            .overlay(
                RoundedRectangle(cornerRadius: Theme.radius.m)
                    .stroke(Color.appSecondary.opacity(0.6), lineWidth: 1)
            )
            .foregroundColor(.appSecondary)
            .cornerRadius(Theme.radius.m)
            .scaleEffect(configuration.isPressed ? 0.98 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}

// MARK: - Ghost Button
struct GhostButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.system(size: 14, weight: .regular))
            .padding(.horizontal, Theme.spacing.l)
            .padding(.vertical, Theme.spacing.s)
            .foregroundColor(.primary)
            .background(Color.clear)
            .overlay(
                RoundedRectangle(cornerRadius: Theme.radius.m)
                    .stroke(Color.appBorder, lineWidth: 1)
            )
            .cornerRadius(Theme.radius.m)
            .opacity(configuration.isPressed ? 0.7 : 1.0)
            .animation(.easeOut(duration: 0.12), value: configuration.isPressed)
    }
}
