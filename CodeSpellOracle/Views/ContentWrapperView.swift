import SwiftUI

struct ContentWrapperView: View {
    @EnvironmentObject var gameState: GameState
    @EnvironmentObject var windowManager: WindowManager
    
    var body: some View {
        MainGameViewPremium()
            .sheet(isPresented: $windowManager.shouldOpenLevelSelection) {
                LevelSelectionView()
                    .environmentObject(gameState)
                    .environmentObject(windowManager)
                    .frame(width: 900, height: 700)
            }
            .sheet(isPresented: $windowManager.shouldOpenAchievements) {
                AchievementView()
                    .environmentObject(gameState)
                    .frame(width: 800, height: 600)
            }
            .sheet(isPresented: $windowManager.shouldOpenLeaderboard) {
                LeaderboardView()
                    .environmentObject(gameState)
                    .frame(width: 700, height: 600)
            }
            .sheet(isPresented: $windowManager.shouldOpenTutorials) {
                TutorialView()
                    .environmentObject(gameState)
                    .frame(width: 900, height: 700)
            }
    }
}
