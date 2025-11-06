import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var gameState: GameState
    @AppStorage("soundEnabled") private var soundEnabled = true
    @AppStorage("musicEnabled") private var musicEnabled = true
    @AppStorage("particlesEnabled") private var particlesEnabled = true
    
    var body: some View {
        TabView {
            GeneralSettings()
                .tabItem {
                    Label("General", systemImage: "gearshape")
                }
            
            ProfileSettings()
                .tabItem {
                    Label("Profile", systemImage: "person")
                }
                .environmentObject(gameState)
            
            AboutSettings()
                .tabItem {
                    Label("About", systemImage: "info.circle")
                }
        }
        .frame(width: 500, height: 400)
    }
}

struct GeneralSettings: View {
    @AppStorage("soundEnabled") private var soundEnabled = true
    @AppStorage("musicEnabled") private var musicEnabled = true
    @AppStorage("particlesEnabled") private var particlesEnabled = true
    
    var body: some View {
        Form {
            Section("Audio") {
                Toggle("Sound Effects", isOn: $soundEnabled)
                Toggle("Background Music", isOn: $musicEnabled)
            }
            
            Section("Visual Effects") {
                Toggle("Particle Effects", isOn: $particlesEnabled)
            }
        }
        .padding()
    }
}

struct ProfileSettings: View {
    @EnvironmentObject var gameState: GameState
    @State private var showResetAlert = false
    
    var body: some View {
        Form {
            Section("Player Info") {
                HStack {
                    Text("Name:")
                    Text(gameState.profile.name)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Rank:")
                    Text(gameState.profile.wizardRank.rawValue)
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Total XP:")
                    Text("\(gameState.profile.totalXP)")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Total Mana:")
                    Text("\(gameState.profile.totalMana) ⚡")
                        .foregroundColor(.secondary)
                }
            }
            
            Section("Data") {
                Button("Reset Progress", role: .destructive) {
                    showResetAlert = true
                }
                .alert("Reset Progress?", isPresented: $showResetAlert) {
                    Button("Cancel", role: .cancel) { }
                    Button("Reset", role: .destructive) {
                        gameState.resetGame()
                    }
                } message: {
                    Text("This will delete all your progress. This action cannot be undone.")
                }
            }
        }
        .padding()
    }
}

struct AboutSettings: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("🧙‍♂️")
                .font(.system(size: 60))
            
            Text("Code Spell Oracle")
                .font(.title)
                .bold()
            
            Text("Version 1.0.0")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text("Learn Python through magical challenges")
                .foregroundColor(.secondary)
            
            Divider()
            
            Text("Built with Swift & SwiftUI")
                .font(.caption)
                .foregroundColor(.secondary)
            
            Text("© 2025")
                .font(.caption)
                .foregroundColor(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding()
    }
}
