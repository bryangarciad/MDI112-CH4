//
//  ContentView.swift
//  HealthTracker Watch App
//
//  Created by Ramses Duran on 12/02/26.


import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = HealthViewModel()
    
    var body: some View {
        NavigationStack {
            MainDashboardView(viewModel: viewModel)
        }
    }
}

#Preview {
    ContentView()
}
