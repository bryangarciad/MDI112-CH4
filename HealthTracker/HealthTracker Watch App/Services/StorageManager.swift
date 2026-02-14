import Foundation
import Combine

class StorageManager {
    // MARK: - Singleton
    static let shared = StorageManager()
    private init() {}
    
    private enum Keys {
        static let userGoals = "user_goals"
    }
    
    // MARK: - UserDefaults
    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - User Goals
    func saveGoals(_ goals: UserGoals) {
        if let enccoded = try? encoder.encode(goals) {
            defaults.set(enccoded, forKey: Keys.userGoals)
        }
    }
    
    func loadGoals() -> UserGoals {
        guard let data = defaults.data(forKey: Keys.userGoals),
              let goals = try? decoder.decode(UserGoals.self, from: data) else {
            return UserGoals.defaultGoals
        }
        
        return goals
    }
}
