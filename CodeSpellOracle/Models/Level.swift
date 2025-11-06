import Foundation

enum Difficulty: String, Codable {
    case beginner = "⭐"
    case intermediate = "⭐⭐"
    case advanced = "⭐⭐⭐"
    case expert = "⭐⭐⭐⭐"
    case master = "⭐⭐⭐⭐⭐"
}

enum Concept: String, Codable {
    case functions
    case conditionals
    case loops
    case lists
    case dictionaries
    case strings
    case advanced
}

struct TestCase: Codable, Identifiable {
    let id = UUID()
    let inputs: [String]
    let expectedOutput: String
    
    enum CodingKeys: String, CodingKey {
        case inputs, expectedOutput
    }
}

struct Level: Identifiable, Codable {
    let id: UUID
    let number: Int
    let title: String
    let difficulty: Difficulty
    let concept: Concept
    let story: String
    let oracleSays: String
    let description: String
    let functionName: String
    let example: String
    let testCases: [TestCase]
    let hints: [String]
    let solution: String
    let xpReward: Int
    let manaReward: Int
    
    enum CodingKeys: String, CodingKey {
        case id, number, title, difficulty, concept, story, oracleSays, description
        case functionName, example, testCases, hints, solution, xpReward, manaReward
    }
    
    init(number: Int,
         title: String, 
         difficulty: Difficulty, 
         concept: Concept,
         story: String, 
         oracleSays: String, 
         description: String,
         functionName: String,
         example: String,
         testCases: [TestCase],
         hints: [String],
         solution: String,
         xpReward: Int = 10,
         manaReward: Int = 5) {
        self.id = UUID()
        self.number = number
        self.title = title
        self.difficulty = difficulty
        self.concept = concept
        self.story = story
        self.oracleSays = oracleSays
        self.description = description
        self.functionName = functionName
        self.example = example
        self.testCases = testCases
        self.hints = hints
        self.solution = solution
        self.xpReward = xpReward
        self.manaReward = manaReward
    }
}

extension Level {
    var difficultyStars: String {
        difficulty.rawValue
    }
    
    var conceptName: String {
        concept.rawValue.capitalized
    }
}
