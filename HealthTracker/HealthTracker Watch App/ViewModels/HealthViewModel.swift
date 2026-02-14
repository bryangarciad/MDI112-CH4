import Combine
import Foundation
import SwiftUI

@MainActor
class HealthViewModel: ObservableObject {
    @Published var goals: UserGoals
    
    @Published var todaysCalories: Double = 0
    @Published var todaysWaters: Double = 0
    
    // MARK: - Model Services
    private let storage = StorageManager.shared
    
    init() {
        self.goals = storage.loadGoals()
    }
    
    func updateGoals(calories: Double, water: Double) {
        goals = UserGoals(dailyCaloriesGoal: calories, dailyWaterGoal: water)
        storage.saveGoals(goals)
    }
}
