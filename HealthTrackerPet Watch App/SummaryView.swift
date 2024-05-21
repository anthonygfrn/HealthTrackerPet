//
//  SummaryView.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 20/05/24.
//

import SwiftUI

struct SummaryView: View {
    @EnvironmentObject var manager: HealthManager

    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                ActivitySummaryView(
                    activityType: .steps,
                    title: "Steps",
                    goal: 10000,
                    icon: "figure.walk",
                    value: manager.steps
                )

                ActivitySummaryView(
                    activityType: .calories,
                    title: "Calories",
                    goal: 900,
                    icon: "flame",
                    value: manager.calories
                )
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Make it fill the screen
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.black, .gray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
        )
    }
}

#Preview {
    SummaryView()
}
