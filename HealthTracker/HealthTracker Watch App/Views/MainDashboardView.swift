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
                            progress: 0.2,
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
                            progress: 0.8,
                            icon: "drop.fill",
                            color: .blue,
                            size: 60
                        )
                        Text("\(Int(viewModel.todaysWaters))/\(Int(viewModel.goals.dailyWaterGoal)) ml")
                            .font(.system(size: 16, weight: .bold, design: .rounded))
                            .foregroundColor(.cyan)
                    }
                }
                
                //NavigationLink()
            }
        }
    }
}

#Preview {
    NavigationStack {
        MainDashboardView(viewModel: HealthViewModel())
    }
}
