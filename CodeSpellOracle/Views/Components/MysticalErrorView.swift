import SwiftUI

struct MysticalErrorView: View {
    let error: MysticalError
    @State private var isExpanded = false
    @State private var glowIntensity: Double = 0.5

    var body: some View {
        VStack(alignment: .leading, spacing: Theme.spacing.m) {
            // Error Header
            Button(action: { withAnimation(.spring()) { isExpanded.toggle() } }) {
                HStack(spacing: Theme.spacing.m) {
                    // Icon with pulsing glow
                    Image(systemName: error.icon)
                        .font(.title2)
                        .foregroundColor(errorColor)
                        .neonGlow(color: errorColor, intensity: glowIntensity)
                        .onAppear {
                            withAnimation(.easeInOut(duration: 1.5).repeatForever()) {
                                glowIntensity = 1.0
                            }
                        }

                    VStack(alignment: .leading, spacing: 4) {
                        Text(error.title)
                            .font(.headline)
                            .foregroundColor(errorColor)

                        Text(error.message)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .lineLimit(isExpanded ? nil : 1)
                    }

                    Spacer()

                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .buttonStyle(.plain)

            // Expanded Details
            if isExpanded {
                VStack(alignment: .leading, spacing: Theme.spacing.m) {
                    Divider()
                        .overlay(errorColor.opacity(0.3))

                    // Line Number
                    if let line = error.errorLine {
                        HStack {
                            Image(systemName: "arrow.forward.circle.fill")
                                .foregroundColor(errorColor)
                            Text("Line \(line)")
                                .font(.system(.caption, design: .monospaced))
                                .foregroundColor(.secondary)
                        }
                    }

                    // Oracle's Wisdom (Hints)
                    if !error.hints.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            Label("Oracle's Wisdom", systemImage: "sparkles")
                                .font(.caption)
                                .foregroundColor(Theme.neon.cosmicBlue)

                            ForEach(Array(error.hints.enumerated()), id: \.offset) { index, hint in
                                HStack(alignment: .top, spacing: 8) {
                                    Text("\(index + 1).")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    Text(hint)
                                        .font(.caption)
                                        .foregroundColor(.primary)
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                            }
                        }
                        .padding(Theme.spacing.m)
                        .background(
                            RoundedRectangle(cornerRadius: Theme.radius.s)
                                .fill(Theme.neon.cosmicBlue.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: Theme.radius.s)
                                        .stroke(Theme.neon.cosmicBlue.opacity(0.3), lineWidth: 1)
                                )
                        )
                    }

                    // Quick Fix
                    if let fix = error.fix {
                        HStack(spacing: Theme.spacing.s) {
                            Image(systemName: "wrench.and.screwdriver.fill")
                                .foregroundColor(Theme.neon.toxicGreen)

                            VStack(alignment: .leading, spacing: 4) {
                                Text("Quick Fix")
                                    .font(.caption.bold())
                                    .foregroundColor(Theme.neon.toxicGreen)

                                Text(fix)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }

                            Spacer()

                            // Future: Click to auto-apply fix
                            Button(action: {}) {
                                Image(systemName: "arrow.right.circle.fill")
                                    .foregroundColor(Theme.neon.toxicGreen)
                            }
                            .buttonStyle(.plain)
                            .opacity(0.5) // Disabled for now
                        }
                        .padding(Theme.spacing.m)
                        .background(
                            RoundedRectangle(cornerRadius: Theme.radius.s)
                                .fill(Theme.neon.toxicGreen.opacity(0.1))
                                .overlay(
                                    RoundedRectangle(cornerRadius: Theme.radius.s)
                                        .stroke(Theme.neon.toxicGreen.opacity(0.3), lineWidth: 1)
                                )
                        )
                    }
                }
                .transition(.opacity.combined(with: .move(edge: .top)))
            }
        }
        .padding(Theme.spacing.l)
        .background(
            RoundedRectangle(cornerRadius: Theme.radius.m)
                .fill(errorColor.opacity(0.05))
                .overlay(
                    RoundedRectangle(cornerRadius: Theme.radius.m)
                        .stroke(errorColor.opacity(0.3), lineWidth: 1)
                )
        )
        .shadow(color: errorColor.opacity(0.2), radius: 8)
    }

    private var errorColor: Color {
        Color(hex: error.color)
    }
}

// MARK: - Preview

#if DEBUG
struct MysticalErrorView_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 20) {
            MysticalErrorView(error: MysticalError(
                title: "🔮 The Arcane Glyph Falters",
                message: "The incantation breaks with forbidden runes",
                hints: [
                    "You've used mystical quotes (\"\") instead of the sacred ASCII runes (\"\")",
                    "The Oracle only understands straight quotes from your keyboard"
                ],
                errorLine: 4,
                fix: "Replace curly quotes with straight quotes: \" instead of \"",
                severity: .critical,
                glyphType: .corruption
            ))

            MysticalErrorView(error: MysticalError(
                title: "👻 Echo in the Void",
                message: "The name 'combine_words' exists not in this realm",
                hints: [
                    "This glyph has not been bound to the material plane",
                    "Did you forget to define a variable or function?"
                ],
                errorLine: 2,
                fix: nil,
                severity: .high,
                glyphType: .fading
            ))
        }
        .padding()
        .background(Color.black)
    }
}
#endif
