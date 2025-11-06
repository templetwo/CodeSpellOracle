import SwiftUI

struct AchievementView: View {
    @EnvironmentObject var gameState: GameState
    @Environment(\.dismiss) var dismiss
    
    let columns = [
        GridItem(.adaptive(minimum: 180), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("Achievements")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                Text("\(unlockedCount)/\(gameState.achievements.count)")
                    .font(.headline)
                    .foregroundColor(.secondary)
                
                Button("Close") {
                    dismiss()
                }
                .buttonStyle(GhostButtonStyle())
            }
            .padding()
            .background(Color(nsColor: .controlBackgroundColor))
            
            // Achievement Grid
            ScrollView {
                LazyVGrid(columns: columns, spacing: 16) {
                    ForEach(gameState.achievements) { achievement in
                        AchievementCard(achievement: achievement)
                    }
                }
                .padding()
            }
        }
    }
    
    var unlockedCount: Int {
        gameState.achievements.filter { $0.unlocked }.count
    }
}

struct AchievementCard: View {
    let achievement: Achievement
    
    var body: some View {
        VStack(spacing: 12) {
            Text(achievement.icon)
                .font(.system(size: 50))
                .opacity(achievement.unlocked ? 1.0 : 0.3)
            
            Text(achievement.name)
                .font(.headline)
                .multilineTextAlignment(.center)
            
            Text(achievement.description)
                .font(.caption)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .lineLimit(2)
            
            HStack {
                Image(systemName: "star.fill")
                    .font(.caption2)
                    .foregroundColor(.yellow)
                Text("\(achievement.points)")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            if achievement.unlocked, let date = achievement.unlockDate {
                Text(date, style: .date)
                    .font(.caption2)
                    .foregroundColor(.green)
            }
        }
        .card()
        .frame(height: 200)
        .grayscale(achievement.unlocked ? 0 : 0.8)
    }
}
