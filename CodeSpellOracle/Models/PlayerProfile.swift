import Foundation

enum WizardRank: String, Codable {
    case apprentice = "✨ Apprentice"
    case scholar = "📚 Scholar"
    case enchanter = "⚗️ Enchanter"
    case masterSorcerer = "🔮 Master Sorcerer"
    case archmage = "🧙 Archmage"
    
    static func rank(for completedLevels: Int) -> WizardRank {
        switch completedLevels {
        case 20...: return .archmage
        case 15..<20: return .masterSorcerer
        case 10..<15: return .enchanter
        case 5..<10: return .scholar
        default: return .apprentice
        }
    }
}

class PlayerProfile: ObservableObject, Codable {
    @Published var name: String
    @Published var wizardRank: WizardRank
    @Published var totalMana: Int
    @Published var totalXP: Int
    @Published var levelsCompleted: [Int]
    @Published var bestTimes: [Int: TimeInterval]
    @Published var creationDate: Date
    @Published var lastPlayed: Date
    @Published var achievementIDs: [String]
    
    enum CodingKeys: String, CodingKey {
        case name, wizardRank, totalMana, totalXP
        case levelsCompleted, bestTimes, creationDate
        case lastPlayed, achievementIDs
    }
    
    init(name: String) {
        self.name = name
        self.wizardRank = .apprentice
        self.totalMana = 0
        self.totalXP = 0
        self.levelsCompleted = []
        self.bestTimes = [:]
        self.creationDate = Date()
        self.lastPlayed = Date()
        self.achievementIDs = []
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        name = try container.decode(String.self, forKey: .name)
        wizardRank = try container.decode(WizardRank.self, forKey: .wizardRank)
        totalMana = try container.decode(Int.self, forKey: .totalMana)
        totalXP = try container.decode(Int.self, forKey: .totalXP)
        levelsCompleted = try container.decode([Int].self, forKey: .levelsCompleted)
        bestTimes = try container.decode([Int: TimeInterval].self, forKey: .bestTimes)
        creationDate = try container.decode(Date.self, forKey: .creationDate)
        lastPlayed = try container.decode(Date.self, forKey: .lastPlayed)
        achievementIDs = try container.decode([String].self, forKey: .achievementIDs)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(wizardRank, forKey: .wizardRank)
        try container.encode(totalMana, forKey: .totalMana)
        try container.encode(totalXP, forKey: .totalXP)
        try container.encode(levelsCompleted, forKey: .levelsCompleted)
        try container.encode(bestTimes, forKey: .bestTimes)
        try container.encode(creationDate, forKey: .creationDate)
        try container.encode(lastPlayed, forKey: .lastPlayed)
        try container.encode(achievementIDs, forKey: .achievementIDs)
    }
    
    func completeLevel(_ levelNumber: Int, time: TimeInterval, xp: Int, mana: Int) {
        if !levelsCompleted.contains(levelNumber) {
            levelsCompleted.append(levelNumber)
            totalXP += xp
            totalMana += mana
        }
        
        // Update best time
        if let existingTime = bestTimes[levelNumber] {
            if time < existingTime {
                bestTimes[levelNumber] = time
            }
        } else {
            bestTimes[levelNumber] = time
        }
        
        // Update rank
        wizardRank = WizardRank.rank(for: levelsCompleted.count)
        lastPlayed = Date()
    }
    
    func unlockAchievement(_ achievementID: String) {
        if !achievementIDs.contains(achievementID) {
            achievementIDs.append(achievementID)
        }
    }
    
    var progressPercentage: Double {
        Double(levelsCompleted.count) / 20.0
    }
}
