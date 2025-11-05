import Foundation

class SaveSystem {
    private let profileKey = "playerProfile"
    private let defaults = UserDefaults.standard
    
    func saveProfile(_ profile: PlayerProfile) {
        do {
            let encoder = JSONEncoder()
            let data = try encoder.encode(profile)
            defaults.set(data, forKey: profileKey)
            print("✅ Profile saved successfully")
        } catch {
            print("❌ Failed to save profile: \(error)")
        }
    }
    
    func loadProfile() -> PlayerProfile? {
        guard let data = defaults.data(forKey: profileKey) else {
            print("No saved profile found")
            return nil
        }
        
        do {
            let decoder = JSONDecoder()
            let profile = try decoder.decode(PlayerProfile.self, from: data)
            print("✅ Profile loaded successfully")
            return profile
        } catch {
            print("❌ Failed to load profile: \(error)")
            return nil
        }
    }
    
    func deleteProfile() {
        defaults.removeObject(forKey: profileKey)
        print("🗑️ Profile deleted")
    }
}
