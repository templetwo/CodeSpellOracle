import Foundation

/// Transforms Python errors into mystical, educational feedback
struct MysticalErrorHandler {

    /// Translates raw Python error into mystical message with teaching hints
    static func translate(_ error: String, code: String) -> MysticalError {
        // Extract error type and message
        if error.contains("SyntaxError") {
            return handleSyntaxError(error, code: code)
        } else if error.contains("NameError") {
            return handleNameError(error, code: code)
        } else if error.contains("TypeError") {
            return handleTypeError(error, code: code)
        } else if error.contains("IndentationError") {
            return handleIndentationError(error, code: code)
        } else if error.contains("AttributeError") {
            return handleAttributeError(error, code: code)
        } else {
            return handleGenericError(error)
        }
    }

    // MARK: - Specific Error Handlers

    private static func handleSyntaxError(_ error: String, code: String) -> MysticalError {
        var hints: [String] = []
        var fix: String? = nil

        if error.contains("invalid character") || error.contains("U+201C") {
            hints = [
                "You've used mystical quotes (\"\") instead of the sacred ASCII runes (\"\")",
                "The Oracle only understands straight quotes from your keyboard"
            ]
            fix = "Replace curly quotes with straight quotes: \" instead of \""
        } else if error.contains("expected ':'") || error.contains("invalid syntax") {
            hints = [
                "All spell incantations must seal with a colon (:)",
                "The arcane structure demands: def spell_name(args):"
            ]
            fix = "Add a colon at the end of your function definition"
        } else if error.contains("unexpected EOF") {
            hints = [
                "The spell is incomplete - the Oracle awaits closure",
                "Every function must have a body (even if just 'pass')"
            ]
            fix = "Add code inside your function or use 'pass' as a placeholder"
        }

        return MysticalError(
            title: "🔮 The Arcane Glyph Falters",
            message: "The incantation breaks with forbidden runes",
            hints: hints,
            errorLine: extractLineNumber(from: error),
            fix: fix,
            severity: .critical,
            glyphType: .corruption
        )
    }

    private static func handleNameError(_ error: String, code: String) -> MysticalError {
        let undefinedName = extractUndefinedName(from: error)

        return MysticalError(
            title: "👻 Echo in the Void",
            message: undefinedName.map { "The name '\($0)' exists not in this realm" } ?? "An undefined essence calls out",
            hints: [
                "This glyph has not been bound to the material plane",
                "Did you forget to define a variable or function?",
                "Check your spelling - the void is case-sensitive"
            ],
            errorLine: extractLineNumber(from: error),
            fix: nil,
            severity: .high,
            glyphType: .fading
        )
    }

    private static func handleTypeError(_ error: String, code: String) -> MysticalError {
        return MysticalError(
            title: "⚡ Rune Mismatch",
            message: "The elements refuse to combine in this configuration",
            hints: [
                "Different types of magic cannot be merged without transformation",
                "Use str(), int(), or float() to convert between forms",
                "Check what type each variable holds"
            ],
            errorLine: extractLineNumber(from: error),
            fix: nil,
            severity: .medium,
            glyphType: .swirling
        )
    }

    private static func handleIndentationError(_ error: String, code: String) -> MysticalError {
        return MysticalError(
            title: "📜 Scroll Misalignment",
            message: "The sacred geometry has been disturbed",
            hints: [
                "Python demands precise indentation - use 4 spaces",
                "All lines in a block must align perfectly",
                "Tabs and spaces cannot mix in the arcane structure"
            ],
            errorLine: extractLineNumber(from: error),
            fix: "Ensure all indented lines use exactly 4 spaces",
            severity: .critical,
            glyphType: .misaligned
        )
    }

    private static func handleAttributeError(_ error: String, code: String) -> MysticalError {
        return MysticalError(
            title: "🌀 Forbidden Property",
            message: "This object does not possess the requested essence",
            hints: [
                "Not all types have the same methods",
                "Use dir(object) to see available methods",
                "Check the documentation for this type"
            ],
            errorLine: extractLineNumber(from: error),
            fix: nil,
            severity: .medium,
            glyphType: .blocked
        )
    }

    private static func handleGenericError(_ error: String) -> MysticalError {
        return MysticalError(
            title: "💥 Spell Backlash",
            message: "An unexpected disturbance ripples through the void",
            hints: [
                "The Oracle sensed something unusual",
                "Review your code for unexpected operations",
                "Check that all functions return what they promise"
            ],
            errorLine: extractLineNumber(from: error),
            fix: nil,
            severity: .medium,
            glyphType: .explosion
        )
    }

    // MARK: - Helpers

    private static func extractLineNumber(from error: String) -> Int? {
        // Extract line number from error string (e.g., "line 4")
        let pattern = #"line (\d+)"#
        if let regex = try? NSRegularExpression(pattern: pattern),
           let match = regex.firstMatch(in: error, range: NSRange(error.startIndex..., in: error)),
           let lineRange = Range(match.range(at: 1), in: error) {
            return Int(error[lineRange])
        }
        return nil
    }

    private static func extractUndefinedName(from error: String) -> String? {
        // Extract variable name from NameError (e.g., "name 'foo' is not defined")
        let pattern = #"name '([^']+)' is not defined"#
        if let regex = try? NSRegularExpression(pattern: pattern),
           let match = regex.firstMatch(in: error, range: NSRange(error.startIndex..., in: error)),
           let nameRange = Range(match.range(at: 1), in: error) {
            return String(error[nameRange])
        }
        return nil
    }
}

// MARK: - Mystical Error Model

struct MysticalError: Identifiable {
    let id = UUID()
    let title: String
    let message: String
    let hints: [String]
    let errorLine: Int?
    let fix: String?
    let severity: Severity
    let glyphType: GlyphType

    enum Severity {
        case critical   // Red neon, screen shake
        case high       // Orange glow, pulse
        case medium     // Yellow shimmer
        case low        // Cyan hint
    }

    enum GlyphType {
        case corruption     // Fracturing lines
        case fading         // Disappearing text
        case swirling       // Particles colliding
        case misaligned     // Geometric distortion
        case blocked        // Shield/barrier
        case explosion      // Radial burst
    }

    var icon: String {
        switch glyphType {
        case .corruption: return "bolt.trianglebadge.exclamationmark"
        case .fading: return "waveform.path.ecg"
        case .swirling: return "tornado"
        case .misaligned: return "arrow.left.and.right.square"
        case .blocked: return "shield.slash"
        case .explosion: return "burst"
        }
    }

    var color: String {
        switch severity {
        case .critical: return "#FF0040"  // Glitch Red
        case .high: return "#FF6B00"      // Orange
        case .medium: return "#FFD700"    // Gold
        case .low: return "#00FFFF"       // Cyan
        }
    }
}

// MARK: - Usage Example
/*
 let error = "SyntaxError: invalid character '"' (U+201C)"
 let mysticalError = MysticalErrorHandler.translate(error, code: userCode)

 // Display in UI:
 // Title: 🔮 The Arcane Glyph Falters
 // Message: The incantation breaks with forbidden runes
 // Hints: ["You've used mystical quotes..."]
 // Fix: "Replace curly quotes with straight quotes"
 */
