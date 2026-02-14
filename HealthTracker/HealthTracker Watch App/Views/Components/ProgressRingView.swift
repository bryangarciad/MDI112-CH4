import SwiftUI

struct ProgressRingView: View {
    
    // MARK: - Properties
    let progress: Double
    let icon: String
    let color: Color
    let size: CGFloat
    
    // MARK: - Constanst
    private let lineWidth: CGFloat = 8
    
    // MARK: - View Body
    var body: some View {
        ZStack {
            // Background Circle
            Circle()
                .stroke(color.opacity(0.2), lineWidth: lineWidth)
            
            // Progress Ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(color, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.easeInOut(duration: 0.5), value: progress)
            
            Image(systemName: icon)
                .font(.system(size: size * 0.3))
                .foregroundColor(color)
        }
        .frame(width: size, height: size)
    }
}

#Preview {
    ProgressRingView(
        progress: 0.2,
        icon: "flame.fill",
        color: .orange,
        size: 60
    )
    ProgressRingView(
        progress: 0.2,
        icon: "drop.fill",
        color: .cyan,
        size: 60
    )
}
