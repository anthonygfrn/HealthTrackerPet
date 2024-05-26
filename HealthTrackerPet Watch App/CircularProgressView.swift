//
//  CircularProgressView.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 21/05/24.
//

import SwiftUI

struct CircularProgressView: View {
    let progress: Double
    let goal: Double
    let icon: String
    let colors: [Color]

    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 6) // Further reduced line width
                .opacity(0.3)
                .foregroundColor(colors.first)

            Circle()
                .trim(from: 0.0, to: CGFloat(min(progress / goal, 1.0)))
                .stroke(
                    LinearGradient(gradient: Gradient(colors: colors), startPoint: .topLeading, endPoint: .bottomTrailing),
                    style: StrokeStyle(lineWidth: 6, lineCap: .round, lineJoin: .round) // Further reduced line width
                )
                .rotationEffect(Angle(degrees: 270.0))
                .animation(.linear, value: progress / goal)

            Image(systemName: icon)
                .font(.title2) // Smaller icon size
                .foregroundColor(colors.last)
        }
    }
}

#Preview {
    CircularProgressView(progress: 5000, goal: 10000, icon: "flame", colors: [.orange, .red])
        .frame(width: 50, height: 50) // Smaller frame size
}
