import AppKit

final class HapticsService {
    static let shared = HapticsService()
    private init() {}
    
    enum Feedback {
        case success, error, selection
    }
    
    func play(_ feedback: Feedback) {
        let performer = NSHapticFeedbackManager.defaultPerformer
        switch feedback {
        case .success:
            performer.perform(.levelChange, performanceTime: .now)
        case .error:
            performer.perform(.alignment, performanceTime: .now)
        case .selection:
            performer.perform(.generic, performanceTime: .now)
        }
    }
}
