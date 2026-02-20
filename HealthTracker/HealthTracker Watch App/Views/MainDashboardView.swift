import SwiftUI

struct MainDashboardView: View {
    @ObservedObject var viewModel: HealthViewModel
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Text("Today")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.gray)
                
                HStack(spacing: 20) {
                    // Calories Ring
                    VStack(spacing: 6) {
                        ProgressRingView(
                            progress: viewModel.caloriesProgress,
                            icon: "flame.fill",
                            color: .orange,
                            size: 60
                        )
                        Text("\(Int(viewModel.todaysCalories))/\(Int(viewModel.goals.dailyCaloriesGoal)) Kcal")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.orange)
                    }
                    
                    // Water Ring
                    VStack(spacing: 6) {
                        ProgressRingView(
                            progress: viewModel.waterProgress,
                            icon: "drop.fill",
                            color: .blue,
                            size: 60
                        )
                        Text("\(Int(viewModel.todaysWaters))/\(Int(viewModel.goals.dailyWaterGoal)) ml")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.cyan)
                    }
                }
                
                // Quick Add Buttons
                // Design Principle: Limited Functionality -- Focused Actions
                HStack(spacing: 12) {
                    NavigationLink(destination: AddEntryView(viewModel: viewModel, entryType: .water)) {
                        QuickAddButton(
                            icon: "plus",
                            label: "Water",
                            color: .cyan
                        )
                    }.buttonStyle(PlainButtonStyle())
                    
                    NavigationLink(destination: AddEntryView(viewModel: viewModel, entryType: .calories)) {
                        QuickAddButton(
                            icon: "plus",
                            label: "Calories",
                            color: .orange
                        )
                    }.buttonStyle(PlainButtonStyle())                }
                
                NavigationLink(destination: GoalSettingsView(viewModel: viewModel)) {
                    HStack {
                        Image(systemName: "gearshape.fill")
                            .font(.system(size: 12))
                        Text("Goals")
                            .font(.system(size: 12))
                    }
                    .foregroundColor(.gray)
                }
                .buttonStyle(PlainButtonStyle())
                .padding(.top, 4)
            }
            .padding(.vertical, 8)
        }
    }
}

#Preview {
    NavigationStack {
        MainDashboardView(viewModel: HealthViewModel())
    }
}
