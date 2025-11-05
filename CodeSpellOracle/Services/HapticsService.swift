import Foundation
import AppKit

class HapticsService {
    static let shared = HapticsService()
    
    private init() {}
    
    func play(_ type: HapticType) {
        switch type {
        case .success:
            NSHapticFeedbackManager.defaultPerformer.perform(.generic, performanceTime: .now)
        case .error:
            NSHapticFeedbackManager.defaultPerformer.perform(.alignment, performanceTime: .now)
        case .warning:
            NSHapticFeedbackManager.defaultPerformer.perform(.levelChange, performanceTime: .now)
        case .light:
            NSHapticFeedbackManager.defaultPerformer.perform(.generic, performanceTime: .now)
        }
    }
    
    enum HapticType {
        case success
        case error
        case warning
        case light
    }
}