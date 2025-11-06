import SwiftUI

struct LeaderboardView: View {
    @Environment(\.dismiss) var dismiss
    @State private var entries: [LeaderboardEntry] = []
    
    var body: some View {
        VStack(spacing: 0) {
            // Header
            HStack {
                Text("🏆 Hall of Fame")
                    .font(.title)
                    .bold()
                
                Spacer()
                
                Button("Close") {
                    dismiss()
                }
            }
            .padding()
            .background(Color(nsColor: .controlBackgroundColor))
            
            // Leaderboard List
            ScrollView {
                VStack(spacing: 12) {
                    if entries.isEmpty {
                        Text("No leaderboard data yet")
                            .foregroundColor(.secondary)
                            .padding()
                    } else {
                        ForEach(Array(entries.enumerated()), id: \.1.id) { index, entry in
                            LeaderboardRow(entry: entry, rank: index + 1)
                        }
                    }
                }
                .padding()
            }
        }
        .onAppear {
            loadLeaderboard()
        }
    }
    
    private func loadLeaderboard() {
        // TODO: Load from Supabase
        // For now, show placeholder
        entries = []
    }
}

struct LeaderboardEntry: Identifiable {
    let id = UUID()
    let name: String
    let rank: String
    let xp: Int
    let mana: Int
    let levelsCompleted: Int
}

struct LeaderboardRow: View {
    let entry: LeaderboardEntry
    let rank: Int
    
    var medalIcon: String {
        switch rank {
        case 1: return "🥇"
        case 2: return "🥈"
        case 3: return "🥉"
        default: return "\(rank)."
        }
    }
    
    var body: some View {
        HStack(spacing: 16) {
            Text(medalIcon)
                .font(.title2)
                .frame(width: 50)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(entry.name)
                    .font(.headline)
                
                Text(entry.rank)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(entry.xp) XP")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                Text("\(entry.levelsCompleted)/20 levels")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color(nsColor: .controlBackgroundColor))
        .cornerRadius(8)
    }
}
