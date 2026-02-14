import SwiftUI

struct GoalSettingsView: View {
    
    @ObservedObject var viewModel: HealthViewModel
    
    @State private var caloriesGoal: Double
    @State private var waterGoal: Double
    
    // MARK: - Preset Options
    private let caloriesPresets: [Double] = [1500, 2000, 2500]
    private let waterPresets: [Double] = [1500, 2000, 2500]
    
    init(viewModel: HealthViewModel) {
        self.viewModel = viewModel
        _caloriesGoal = State(initialValue: viewModel.goals.dailyCaloriesGoal)
        _waterGoal = State(initialValue: viewModel.goals.dailyWaterGoal)
    }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Calories Goal Section
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.orange)
                        Text("Calories Goal")
                            .font(.system(size: 13, weight: .medium))
                        Spacer()
                    }
                    
                    Text("\(Int(caloriesGoal)) kCal")
                        .font(.system(size: 20, weight: .medium))
                        .foregroundColor(.orange)
                    
                    // Preset Buttons
                    // Design Principle On tap
                    HStack(spacing: 6) {
                        ForEach(caloriesPresets, id: \.self) { preset in
                            Button {
                                caloriesGoal = preset
                            } label: {
                                Text("\(Int(preset))")
                                    .font(.system(size: 11, weight: .medium))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 6)
                                    .background(
                                        caloriesGoal == preset
                                        ? Color.orange
                                        : Color.orange.opacity(0.2)
                                    )
                                    .foregroundColor(caloriesGoal == preset ? .black : .orange)
                                    .cornerRadius(8)
                            }
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    
                        
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        GoalSettingsView(viewModel: HealthViewModel())
    }
}
