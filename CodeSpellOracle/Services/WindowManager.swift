import SwiftUI
import AppKit

class WindowManager: ObservableObject {
    @Published var shouldOpenLevelSelection = false
    @Published var shouldOpenAchievements = false
    @Published var shouldOpenLeaderboard = false
    @Published var shouldOpenTutorials = false
    
    func openLevelSelection() {
        shouldOpenLevelSelection = true
        // Open new window using NSWorkspace
        if let url = NSWorkspace.shared.urlForApplication(withBundleIdentifier: Bundle.main.bundleIdentifier ?? "") {
            let config = NSWorkspace.OpenConfiguration()
            config.createsNewApplicationInstance = false
            NSWorkspace.shared.open([url], withApplicationAt: url, configuration: config)
        }
    }
    
    func openAchievements() {
        shouldOpenAchievements = true
    }
    
    func openLeaderboard() {
        shouldOpenLeaderboard = true
    }
    
    func openTutorials() {
        shouldOpenTutorials = true
    }
    
    func openHelp() {
        // Show help alert
        let alert = NSAlert()
        alert.messageText = "Code Spell Oracle Help"
        alert.informativeText = """
        Keyboard Shortcuts:
        ⌘R - Run Code
        ⌘H - Show Hint
        ⌘⇧L - Level Selection
        ⌘⇧A - Achievements
        ⌘⇧B - Leaderboard
        ⌘⇧T - Tutorials
        """
        alert.alertStyle = .informational
        alert.runModal()
    }
}
