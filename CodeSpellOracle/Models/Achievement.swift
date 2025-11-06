import Foundation

struct Achievement: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let points: Int
    let icon: String
    var unlocked: Bool = false
    var unlockDate: Date?
    
    static let allAchievements: [Achievement] = [
        Achievement(
            id: "first_spell",
            name: "First Spell",
            description: "Complete your first level",
            points: 10,
            icon: "✨"
        ),
        Achievement(
            id: "quick_learner",
            name: "Quick Learner",
            description: "Complete 5 levels",
            points: 25,
            icon: "🎓"
        ),
        Achievement(
            id: "halfway",
            name: "Halfway There",
            description: "Complete 10 levels",
            points: 50,
            icon: "🌟"
        ),
        Achievement(
            id: "master",
            name: "Master Wizard",
            description: "Complete all 20 levels",
            points: 100,
            icon: "🧙‍♂️"
        ),
        Achievement(
            id: "perfectionist",
            name: "Perfectionist",
            description: "Complete a level without hints",
            points: 20,
            icon: "💯"
        ),
        Achievement(
            id: "speed_demon",
            name: "Speed Demon",
            description: "Complete a level in under 30 seconds",
            points: 30,
            icon: "⚡"
        ),
        Achievement(
            id: "persistent",
            name: "Persistent",
            description: "Try 10 times on a single level",
            points: 15,
            icon: "🔁"
        ),
        Achievement(
            id: "explorer",
            name: "Explorer",
            description: "Open all window types",
            points: 10,
            icon: "🗺️"
        ),
        Achievement(
            id: "scholar",
            name: "Scholar",
            description: "View all tutorials",
            points: 25,
            icon: "📚"
        ),
        Achievement(
            id: "night_owl",
            name: "Night Owl",
            description: "Play after midnight",
            points: 15,
            icon: "🦉"
        ),
        Achievement(
            id: "early_bird",
            name: "Early Bird",
            description: "Play before 6 AM",
            points: 15,
            icon: "🐦"
        ),
        Achievement(
            id: "collector",
            name: "Mana Collector",
            description: "Collect 500 total mana",
            points: 40,
            icon: "⚡"
        ),
        Achievement(
            id: "sage",
            name: "Sage",
            description: "Reach 1000 XP",
            points: 50,
            icon: "🔮"
        ),
        Achievement(
            id: "side_quester",
            name: "Side Quester",
            description: "Complete 3 side quests",
            points: 35,
            icon: "🎯"
        ),
        Achievement(
            id: "code_master",
            name: "Code Master",
            description: "Write a solution under 3 lines",
            points: 25,
            icon: "📝"
        )
    ]
}

struct SideQuest: Identifiable, Codable {
    let id: String
    let name: String
    let description: String
    let requirement: String
    let rewardMana: Int
    let rewardXP: Int
    var completed: Bool = false
    var completionDate: Date?
    
    static let allQuests: [SideQuest] = [
        SideQuest(
            id: "speed_run_1",
            name: "Speed Run: Beginner",
            description: "Complete levels 1-3 in under 2 minutes total",
            requirement: "Complete levels 1, 2, 3 with total time < 120s",
            rewardMana: 50,
            rewardXP: 100
        ),
        SideQuest(
            id: "no_hints_challenge",
            name: "Pure Skill",
            description: "Complete any 3 levels without using hints",
            requirement: "Complete 3 levels with 0 hints",
            rewardMana: 75,
            rewardXP: 150
        ),
        SideQuest(
            id: "perfect_streak",
            name: "Perfect Streak",
            description: "Complete 3 levels in a row on first attempt",
            requirement: "Complete 3 consecutive levels with 1 attempt each",
            rewardMana: 100,
            rewardXP: 200
        ),
        SideQuest(
            id: "tutorial_master",
            name: "Knowledge Seeker",
            description: "View all available tutorials",
            requirement: "Open all 5 tutorial topics",
            rewardMana: 30,
            rewardXP: 60
        ),
        SideQuest(
            id: "code_golf",
            name: "Code Golf Champion",
            description: "Write solutions under 50 characters for 3 levels",
            requirement: "Complete 3 levels with solution length < 50",
            rewardMana: 80,
            rewardXP: 160
        )
    ]
}

