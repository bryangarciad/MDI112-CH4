import SwiftUI

struct AddEntryView: View {
    @ObservedObject var viewModel: HealthViewModel
    let entryType: EntryType
    
    @State private var selectedAmount: Double = 0
    @Environment(\.dismiss) private var dismiss
    
    private var quickAddOptions: [Double] { [100, 200, 300, 500] }
    
    var body: some View {
        ScrollView {
            VStack(spacing: 16) {
                Image(systemName: entryType.icon)
                    .font(.system(size: 28))
                    .foregroundColor(entryType.color)
                
                Text("Add \(entryType == .calories ? "Calories" : "Water")")
                    .font(.system(size: 14, weight: .medium))
                
                Text("\(Int(selectedAmount)) \(entryType.unit)")          .font(.system(size: 24, weight: .bold, design: .rounded))
                    .foregroundColor(entryType.color)
                
                LazyVGrid(columns: [
                    GridItem(.flexible()), GridItem(.flexible())
                ], spacing: 10) {
                    ForEach(quickAddOptions, id: \.self) {amount in
                        Button {
                            selectedAmount = amount
                        } label: {
                            Text("+\(Int(amount))")
                                .font(.system(size: 14, weight: .semibold))
                                .frame(maxWidth: .infinity)
                                .padding(.vertical, 10)
                                .background(
                                    selectedAmount == amount
                                    ? entryType.color
                                    : Color.gray.opacity(0.4)
                                )
                                .foregroundColor(
                                    selectedAmount == amount ? .black : .white
                                )
                                .cornerRadius(10)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                
                HStack {
                    Button {
                        selectedAmount = max(0, selectedAmount - 50)
                    } label: {
                        Image(systemName: "minus.circle")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Spacer()
                    
                    Text("Adjust")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                    
                    Spacer()
                    
                    Button {
                        selectedAmount += 50
                    } label: {
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24))
                            .foregroundColor(.gray)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.horizontal, 8)
                
                Button {
                    if selectedAmount > 0 {
                        if entryType == .calories {
                            viewModel.addCalories(selectedAmount)
                        } else {
                            viewModel.addWater(selectedAmount)
                        }
                    }
                } label: {
                    Text("Add")
                        .font(.system(size: 16, weight: .bold))
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 12)
                        .background(entryType.color)
                        .cornerRadius(12)
                }
                .buttonStyle(PlainButtonStyle())
                .disabled(selectedAmount == 0)
            }
            .padding(.horizontal, 8)
            .padding(.vertical, 8)
        }
        .navigationTitle(entryType == .calories ? "Calories" : "Water")
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        AddEntryView(viewModel: HealthViewModel(), entryType: .calories)
    }
}
