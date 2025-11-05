import SwiftUI

struct TutorialView: View {
    @Environment(\.dismiss) var dismiss
    @State private var selectedTopic: TutorialTopic = .functions
    
    var body: some View {
        HStack(spacing: 0) {
            // Sidebar
            VStack(alignment: .leading, spacing: 8) {
                Text("Tutorials")
                    .font(.headline)
                    .padding()
                
                ForEach(TutorialTopic.allCases) { topic in
                    Button(action: { selectedTopic = topic }) {
                        HStack {
                            Image(systemName: topic.icon)
                            Text(topic.rawValue)
                            Spacer()
                        }
                        .padding()
                        .background(selectedTopic == topic ? Color.blue.opacity(0.2) : Color.clear)
                        .cornerRadius(8)
                    }
                    .buttonStyle(.plain)
                }
                
                Spacer()
            }
            .frame(width: 200)
            .background(Color(nsColor: .controlBackgroundColor))
            
            Divider()
            
            // Content
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text(selectedTopic.rawValue)
                        .font(.title)
                        .bold()
                    
                    Text(selectedTopic.content)
                        .font(.body)
                    
                    Text("Example:")
                        .font(.headline)
                    
                    Text(selectedTopic.example)
                        .font(.system(.body, design: .monospaced))
                        .padding()
                        .background(Color(nsColor: .textBackgroundColor))
                        .cornerRadius(8)
                }
                .padding()
            }
        }
    }
}

enum TutorialTopic: String, CaseIterable, Identifiable {
    case functions = "Functions"
    case conditionals = "Conditionals"
    case loops = "Loops"
    case lists = "Lists"
    case dictionaries = "Dictionaries"
    
    var id: String { rawValue }
    
    var icon: String {
        switch self {
        case .functions: return "function"
        case .conditionals: return "arrow.triangle.branch"
        case .loops: return "arrow.trianglehead.2.clockwise.rotate.90"
        case .lists: return "list.bullet"
        case .dictionaries: return "book"
        }
    }
    
    var content: String {
        switch self {
        case .functions:
            return "Functions are reusable blocks of code that perform a specific task. They help organize your code and make it more readable."
        case .conditionals:
            return "Conditionals let you make decisions in your code. Use if, elif, and else to execute different code based on conditions."
        case .loops:
            return "Loops let you repeat code multiple times. Use 'for' loops when you know how many times to repeat, and 'while' loops when you need to repeat until a condition is met."
        case .lists:
            return "Lists store multiple items in a single variable. They're ordered, changeable, and allow duplicate values."
        case .dictionaries:
            return "Dictionaries store key-value pairs. They're unordered, changeable, and don't allow duplicate keys."
        }
    }
    
    var example: String {
        switch self {
        case .functions:
            return "def greet(name):\n    return f\"Hello, {name}!\"\n\nprint(greet(\"Alice\"))"
        case .conditionals:
            return "age = 18\n\nif age >= 18:\n    print(\"Adult\")\nelse:\n    print(\"Minor\")"
        case .loops:
            return "for i in range(5):\n    print(i)\n\ncount = 0\nwhile count < 3:\n    print(count)\n    count += 1"
        case .lists:
            return "fruits = [\"apple\", \"banana\", \"cherry\"]\nprint(fruits[0])  # apple\nfruits.append(\"orange\")"
        case .dictionaries:
            return "person = {\"name\": \"Alice\", \"age\": 25}\nprint(person[\"name\"])  # Alice\nperson[\"city\"] = \"NYC\""
        }
    }
}
