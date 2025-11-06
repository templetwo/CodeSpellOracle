import SwiftUI
import Combine

@MainActor
class GameState: ObservableObject {
    @Published var profile: PlayerProfile
    @Published var currentLevel: Level?
    @Published var levels: [Level] = []
    @Published var achievements: [Achievement] = Achievement.allAchievements
    @Published var sideQuests: [SideQuest] = SideQuest.allQuests
    @Published var isPlaying: Bool = false
    
    private let saveSystem = SaveSystem()
    private let pythonSandbox = PythonSandboxService()
    
    init() {
        // Load or create profile
        if let savedProfile = saveSystem.loadProfile() {
            self.profile = savedProfile
        } else {
            self.profile = PlayerProfile(name: "Apprentice")
        }
        
        // Load all levels
        self.levels = LevelDefinitions.allLevels
    }
    
    func startLevel(_ level: Level) {
        currentLevel = level
        isPlaying = true
    }
    
    func submitCode(_ code: String) async -> [TestResult] {
        guard let level = currentLevel else { return [] }
        
        do {
            let results = try await pythonSandbox.testFunction(
                code: code,
                functionName: level.functionName,
                testCases: level.testCases
            )
            
            // Check if all tests passed
            if results.allSatisfy({ $0.passed }) {
                completeLevel(level, results: results)
            }
            
            return results
        } catch {
            print("Execution error: \(error)")
            return []
        }
    }
    
    private func completeLevel(_ level: Level, results: [TestResult]) {
        let time: TimeInterval = 0 // TODO: Track actual time
        profile.completeLevel(level.number, time: time, xp: level.xpReward, mana: level.manaReward)
        
        // Check achievements
        checkAchievements(levelNumber: level.number)
        
        // Save progress
        saveSystem.saveProfile(profile)
    }
    
    private func checkAchievements(levelNumber: Int) {
        // First spell
        if profile.levelsCompleted.count == 1 {
            unlockAchievement("first_spell")
        }
        
        // Quick learner
        if profile.levelsCompleted.count == 5 {
            unlockAchievement("quick_learner")
        }
        
        // Halfway
        if profile.levelsCompleted.count == 10 {
            unlockAchievement("halfway")
        }
        
        // Master
        if profile.levelsCompleted.count == 20 {
            unlockAchievement("master")
        }
        
        // Mana collector
        if profile.totalMana >= 500 {
            unlockAchievement("collector")
        }
        
        // Sage
        if profile.totalXP >= 1000 {
            unlockAchievement("sage")
        }
    }
    
    private func unlockAchievement(_ id: String) {
        if let index = achievements.firstIndex(where: { $0.id == id }) {
            achievements[index].unlocked = true
            achievements[index].unlockDate = Date()
            profile.unlockAchievement(id)
        }
    }
    
    func resetGame() {
        profile = PlayerProfile(name: "Apprentice")
        currentLevel = nil
        isPlaying = false
        saveSystem.saveProfile(profile)
    }
    
    func nextLevel() -> Level? {
        return levels.first { !profile.levelsCompleted.contains($0.number) }
    }
}
