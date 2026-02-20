import Combine
import Foundation
import SwiftUI

@MainActor
class HealthViewModel: ObservableObject {
    @Published var goals: UserGoals
    
    @Published var todaysCalories: Double = 0
    @Published var todaysWaters: Double = 0
    
    var caloriesProgress: Double {
        min(todaysCalories / goals.dailyCaloriesGoal, 1.0)
    }
    
    var waterProgress: Double {
        min(todaysWaters / goals.dailyWaterGoal, 1.0)
    }
    
    // MARK: - Model Services
    private let storage = StorageManager.shared
    
    init() {
        self.goals = storage.loadGoals()
        refreshTodaysDate()
    }
    
    func updateGoals(calories: Double, water: Double) {
        goals = UserGoals(dailyCaloriesGoal: calories, dailyWaterGoal: water)
        storage.saveGoals(goals)
    }
    
    // MARK: - Diary Entries
    func refreshTodaysDate() {
        todaysCalories = storage.getTodaysTotal(for: .calories)
        todaysWaters = storage.getTodaysTotal(for: .water)
    }
    
    func addWater(_ amount: Double) {
        let diaryEntry = DiaryEntry(type: .water, value: amount)
        storage.addEntryFromUserInput(diaryEntry)
        
        todaysWaters += amount
    }
    
    func addCalories(_ amount: Double) {
        let diaryEntry = DiaryEntry(type: .calories, value: amount)
        storage.addEntryFromUserInput(diaryEntry)
        
        todaysCalories += amount
    }}
