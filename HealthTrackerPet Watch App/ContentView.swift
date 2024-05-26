// File: ContentView.swift
import SwiftUI

struct ContentView: View {
    @EnvironmentObject var manager: HealthManager

    var body: some View {
        ScrollView { // Allow scrolling if content exceeds screen size
            VStack(spacing: 20) {
                ActivityView(
                    activityType: .steps,
                    title: "Today Steps",
                    goal: 10000,
                    icon: "figure.walk",
                    value: manager.steps
                )
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(15)

                ActivityView(
                    activityType: .caloriesBurned,
                    title: "Today Calories Burned",
                    goal: 900,
                    icon: "flame",
                    value: manager.calories
                )
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.orange, .red]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(15)

                ActivityView(
                    activityType: .caloriesTaken,
                    title: "Today Calories Taken",
                    goal: 2000,
                    icon: "fork.knife",
                    value: manager.totalCaloriesTaken
                )
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.green, .yellow]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(15)

                ActivityView(
                    activityType: .workout,
                    title: "Today Workout Minutes",
                    goal: 30,
                    icon: "figure.run",
                    value: manager.workoutMinutes
                )
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [.purple, .pink]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(15)
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(HealthManager())
}
