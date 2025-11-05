import SwiftUI

@main
struct CodeSpellOracleApp: App {
    @StateObject private var gameState = GameState()
    @StateObject private var windowManager = WindowManager()
    
    var body: some Scene {
        // Main Game Window
        WindowGroup("Code Spell Oracle") {
            ContentWrapperView()
                .environmentObject(gameState)
                .environmentObject(windowManager)
                .frame(minWidth: 1200, minHeight: 700)
        }
        .defaultSize(width: 1400, height: 800)
        .commands {
            CommandGroup(replacing: .newItem) {
                Button("New Game") {
                    gameState.resetGame()
                }
                .keyboardShortcut("n", modifiers: .command)
            }
            
            CommandGroup(after: .windowArrangement) {
                Button("Level Selection") {
                    windowManager.openLevelSelection()
                }
                .keyboardShortcut("l", modifiers: [.command, .shift])
                
                Button("Achievements") {
                    windowManager.openAchievements()
                }
                .keyboardShortcut("a", modifiers: [.command, .shift])
                
                Button("Leaderboard") {
                    windowManager.openLeaderboard()
                }
                .keyboardShortcut("b", modifiers: [.command, .shift])
                
                Button("Tutorials") {
                    windowManager.openTutorials()
                }
                .keyboardShortcut("t", modifiers: [.command, .shift])
            }
            
            CommandGroup(after: .help) {
                Button("Show Commands") {
                    windowManager.openHelp()
                }
                .keyboardShortcut("?", modifiers: .command)
            }
        }
        
        // Settings Window
        Settings {
            SettingsView()
                .environmentObject(gameState)
        }
    }
}
