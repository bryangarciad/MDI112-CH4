import Foundation
import Combine

class StorageManager {
    // MARK: - Singleton
    static let shared = StorageManager()
    private init() {}
    
    private enum Keys {
        static let userGoals = "user_goals"
        static let diaryEntries = "diary_entries"
    }
    
    // MARK: - UserDefaults
    private let defaults = UserDefaults.standard
    private let encoder = JSONEncoder()
    private let decoder = JSONDecoder()
    
    // MARK: - User Goals
    func saveGoals(_ goals: UserGoals) {
        if let encoded = try? encoder.encode(goals) {
            defaults.set(encoded, forKey: Keys.userGoals)
        }
    }
    
    func loadGoals() -> UserGoals {
        guard let data = defaults.data(forKey: Keys.userGoals),
              let goals = try? decoder.decode(UserGoals.self, from: data) else {
            return UserGoals.defaultGoals
        }
        
        return goals
    }
    
    // MARK: - Diary Entries
    
    // Writing Process To The Storage
    func saveDiaryEntries(_ entries: [DiaryEntry]) {
        if let encoded = try? encoder.encode(entries) { // Nil = False
            defaults.set(encoded, forKey: Keys.diaryEntries)
        }
    }
    
    // Read From Storage
    func loadEntries() -> [DiaryEntry] {
        guard let data = defaults.data(forKey: Keys.diaryEntries), // JSON Version of The Data (Encoded Data)
              let diaryEntries = try? decoder.decode([DiaryEntry].self, from: data) else {
            return []
        }
        
        return diaryEntries
    }
    
    func addEntryFromUserInput(_ entry: DiaryEntry) {
        var entries = loadEntries()
        entries.append(entry)
        saveDiaryEntries(entries)
    }
    
    func getTodaysEntries() -> [DiaryEntry] {
        let entries = loadEntries()
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date()) // 2026-02-14T13:20:00.000 -> 2026-02-14T00:00:00.000 ISO6001
        
        
        return entries.filter { entry in
            calendar.isDate(entry.timestamp, inSameDayAs: today)
        }
    }
    
    func getTodaysTotal(for type: EntryType) -> Double {
        getTodaysEntries().filter { $0.type == type }.reduce(0) {$0 + $1.value}
    }
    
    func clearAllDiaryData() {
        defaults.removeObject(forKey: Keys.diaryEntries)
    }
    
}
