//
//  ActivitySummaryView.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 20/05/24.
//

import SwiftUI

struct ActivitySummaryView: View {
    let activityType: ActivityType
    let title: String
    let goal: Double
    let icon: String
    var value: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 12) { // Adjust spacing for better visual balance
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .bold))
                Text(title)
                    .font(.headline)
            }
            .foregroundColor(.white)

            HStack { // Horizontal layout for progress text and Gauge
                Text("\(Int(value)) / \(Int(goal))")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)

                Spacer() // Push Gauge to the right

                Gauge(value: value, in: 0...goal) {
                    // Empty view as gauge is decorative
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .tint(.white)
                .frame(width: 50) // Adjust Gauge size as needed
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(
                        gradient: getGradient(for: activityType),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
    }
    
    // Helper function to get the appropriate gradient color
    private func getGradient(for activityType: ActivityType) -> Gradient {
        switch activityType {
        case .steps:
            return Gradient(colors: [.blue, .purple])
        case .calories:
            return Gradient(colors: [.orange, .red])
        }
    }
}

#Preview {
    ActivitySummaryView(
        activityType: .steps,     // Provide a default activity type
        title: "Daily Steps",     // Provide a default title
        goal: 10000,             // Provide a default goal
        icon: "figure.walk",     // Provide a default icon
        value: 6545              // Provide a default value
    )
}
