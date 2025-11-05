import SwiftUI

struct LevelSelectionView: View {
    @EnvironmentObject var gameState: GameState
    @Environment(\.dismiss) var dismiss
    
    let columns = [
        GridItem(.adaptive(minimum: 200), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Level Selection")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(GhostButtonStyle())
            }
            .padding()
            .background(Color(nsColor: .controlBackgroundColor))
            
            // Level Grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(gameState.levels) { level in
                        Button(action: {
                            gameState.startLevel(level)
                            dismiss()
                        }) {
                            LevelCard(level: level)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding()
            }
        }
    }
}

struct LevelCard: View {
    @EnvironmentObject var gameState: GameState
    let level: Level
    @State private var hovering: Bool = false
    
    var isCompleted: Bool {
        gameState.profile.levelsCompleted.contains(level.number)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text("Level \(level.number)")
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                if isCompleted {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.green)
                }
            }
            
            Text(level.title)
                .font(.headline)
                .lineLimit(2)
            
            Text(level.difficultyStars)
                .font(.caption)
            
            Text(level.conceptName)
                .tagStyle(.appInfo)
        }
        .frame(height: 140)
        .card()
        .overlay(
            RoundedRectangle(cornerRadius: Theme.radius.m)
                .stroke(isCompleted ? Color.appSuccess.opacity(0.6) : Color.clear, lineWidth: 2)
        )
        .scaleEffect(hovering ? 1.02 : 1.0)
        .onHover { hovering = $0 }
        .animation(.easeOut(duration: 0.12), value: hovering)
    }
}
