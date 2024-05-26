// File: SummaryView.swift
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
                    activityType: .caloriesBurned,
                    title: "Calories Burned",
                    goal: 900,
                    icon: "flame",
                    value: manager.calories
                )

                ActivitySummaryView(
                    activityType: .caloriesTaken,
                    title: "Calories Taken",
                    goal: 2000,
                    icon: "fork.knife",
                    value: manager.totalCaloriesTaken
                )

                ActivitySummaryView(
                    activityType: .workout,
                    title: "Workout Minutes",
                    goal: 30,
                    icon: "figure.run",
                    value: manager.workoutMinutes
                )
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity) // Make it fill the screen
        .background(
            LinearGradient(
                gradient: Gradient(colors: [.black, .gray]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    SummaryView()
        .environmentObject(HealthManager())
}
