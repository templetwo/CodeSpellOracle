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
        
        if let player = audioPlayers[soundName] {
            player.volume = volume
            player.play()
            return
        }
        
        guard let url = Bundle.main.url(forResource: soundName, withExtension: "wav") else {
            print("Sound file not found: \(soundName)")
            return
        }
        
        do {
            let player = try AVAudioPlayer(contentsOf: url)
            audioPlayers[soundName] = player
            player.volume = volume
            player.play()
        } catch {
            print("Error loading sound: \(error)")
        }
    }
    
    func playTypingSound(for character: Character) {
        guard soundEnabled else { return }
        
        // Vary pitch based on character type
        let _ = character.isLetter ? 1.0 : 0.8  // pitch variation could be used for future enhancement
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
        
        guard let url = Bundle.main.url(forResource: "background_music", withExtension: "mp3") else {
            print("Background music file not found")
            return
        }
        
        do {
            backgroundMusicPlayer = try AVAudioPlayer(contentsOf: url)
            backgroundMusicPlayer?.numberOfLoops = -1
            backgroundMusicPlayer?.volume = 0.5
            backgroundMusicPlayer?.play()
        } catch {
            print("Error playing background music: \(error)")
        }
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