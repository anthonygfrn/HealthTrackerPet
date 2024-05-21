//
//  ActivityView.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 20/05/24.
//

import SwiftUI

enum ActivityType {
    case steps, calories
}

struct ActivityView: View {
    let activityType: ActivityType
    let title: String
    let goal: Double
    let icon: String
    var value: Double

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .bold))
                Text(title)
                    .font(.headline)
            }
            .foregroundColor(.white) // Ensure icons and text are visible on gradient

            Text("\(Int(value)) / \(Int(goal))")
                .font(.system(size: 18, weight: .semibold))
                .foregroundColor(.white)

            if activityType == .steps {
                Gauge(value: value, in: 0...goal) {
                    // Empty view as gauge is decorative
                }
                .gaugeStyle(.accessoryCircularCapacity)
                .tint(.white) // Customize gauge color
            }
        }
        .padding()
    }
}

#Preview {
    ActivityView(
        activityType: .steps,        // Specify the activity type
        title: "Daily Steps",        // Title of the activity
        goal: 10000,                // Example goal for steps
        icon: "figure.walk",        // Icon to represent steps
        value: 6545                 // Example value for steps
    )
}
