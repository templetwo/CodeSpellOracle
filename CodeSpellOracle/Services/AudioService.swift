import AVFoundation
import SwiftUI

class AudioService: ObservableObject {
    static let shared = AudioService()
    
    @Published var soundEnabled: Bool = true
    @Published var musicEnabled: Bool = true
    
    private var audioPlayers: [String: AVAudioPlayer] = [:]
    private var backgroundMusicPlayer: AVAudioPlayer?
    
    private init() {
        loadSettings()
    }
    
    // MARK: - Settings
    
    func loadSettings() {
        soundEnabled = UserDefaults.standard.bool(forKey: "soundEnabled")
        musicEnabled = UserDefaults.standard.bool(forKey: "musicEnabled")
    }
    
    // MARK: - Sound Effects
    
    func playSound(_ soundName: String, volume: Float = 1.0) {
        guard soundEnabled else { return }
        
        // TODO: Implement actual sound playback
        // For now, this is a stub that can be implemented with actual sound files
        print("🔊 Playing sound: \(soundName)")
    }
    
    func playTypingSound(for character: Character) {
        guard soundEnabled else { return }
        
        // Vary pitch based on character type
        let pitch: Float = character.isLetter ? 1.0 : 0.8
        playSound("typing", volume: 0.3)
    }
    
    func playSuccess() {
        playSound("success", volume: 0.7)
    }
    
    func playError() {
        playSound("error", volume: 0.5)
    }
    
    func playLevelComplete() {
        playSound("level_complete", volume: 0.8)
    }
    
    func playAchievementUnlock() {
        playSound("achievement", volume: 0.9)
    }
    
    func playSpellCast() {
        playSound("spell_cast", volume: 0.6)
    }
    
    // MARK: - Background Music
    
    func startBackgroundMusic() {
        guard musicEnabled else { return }
        
        // TODO: Implement background music
        print("🎵 Starting background music")
    }
    
    func stopBackgroundMusic() {
        backgroundMusicPlayer?.stop()
    }
    
    func updateMusicForRank(_ rank: WizardRank) {
        guard musicEnabled else { return }
        
        // TODO: Change music based on wizard rank
        print("🎵 Updating music for rank: \(rank.rawValue)")
    }
}

// MARK: - Sound Assets Guide

/*
 Required Sound Files (to be added to Resources/Sounds/):
 
 1. typing.wav - Mechanical keyboard click
 2. success.wav - Success chime
 3. error.wav - Error tone
 4. level_complete.wav - Victory fanfare
 5. achievement.wav - Achievement unlock sound
 6. spell_cast.wav - Magic casting whoosh
 7. background_music.mp3 - Ambient cyberpunk track
 
 Recommended Tools:
 - FreeSound.org - Free sound effects
 - Incompetech.com - Royalty-free music
 - SFXR - Generate retro game sounds
 - GarageBand - Create custom sounds
 
 Format Guidelines:
 - Format: WAV or MP3
 - Sample Rate: 44.1kHz
 - Bit Depth: 16-bit
 - Keep files under 500KB each
 */
