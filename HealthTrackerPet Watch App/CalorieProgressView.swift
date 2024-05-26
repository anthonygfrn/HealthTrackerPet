// File: CalorieProgressView.swift
import SwiftUI
import WatchKit

struct CalorieProgressView: View {
    @EnvironmentObject var manager: HealthManager
    @State private var initialWeight = 87.0 // Initial weight in kg
    @State private var targetWeight = 86.0 // Target weight in kg
    @State private var days = 30 // Number of days to achieve the goal
    
    private let circleRadius: CGFloat = 65 // Adjust this for desired width

    private var dailyCalorieDeficit: Double {
        let weightChange = initialWeight - targetWeight
        let totalCaloriesToChange = weightChange * 7700 // 1 kg of fat = 7700 kcal
        return totalCaloriesToChange / Double(days)
    }

    private var adjustedDailyCalorieDeficit: Double {
        return dailyCalorieDeficit - (manager.totalCaloriesTaken - manager.caloriesBurned)
    }

    private var caloriesRemaining: Double {
        return adjustedDailyCalorieDeficit
    }

    private var petState: PetState {
        if caloriesRemaining >= -50 && caloriesRemaining <= 50 {
            return .healthy
        } else if caloriesRemaining > 50 {
            return .overweight
        } else {
            return .underfed
        }
    }

    private enum PetState {
        case healthy, overweight, underfed
    }

    var body: some View {
        ZStack {
            VStack {
                // Image Labels (Moved to the top)
                HStack {
                    Image(systemName: "flame.fill")
                        .font(.footnote)
                    
                    Image(systemName: "fork.knife")
                        .font(.footnote)
                }
                .padding(.bottom, 5)
                // Circle Progress & Markers
                ZStack {
                    // Pet Image (Based on State)
                    Image(getPetImageName())
                        .resizable()
                        .frame(width: 80, height: 80) // Adjust size for watchOS
                        .aspectRatio(contentMode: .fit)

                    // Markers (Based on Goal)
                    ForEach(0..<Int(dailyCalorieDeficit / 400), id: \.self) { i in
                        Circle()
                            .frame(width: 6, height: 6)
                            .foregroundColor(.white) // Make markers visible
                            .offset(y: -circleRadius)
                            .rotationEffect(.degrees(Double(i) * 360 / Double(dailyCalorieDeficit / 400)))
                    }
                    
                    Circle()
                        .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.secondary)
                        .frame(width: circleRadius * 2, height: circleRadius * 2)

                    // Burned Calories (Blue)
                    Circle()
                        .trim(from: 0.5 - CGFloat(manager.caloriesBurned) / CGFloat(dailyCalorieDeficit) / 2, to: 0.5)
                        .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.blue)
                        .frame(width: circleRadius * 2, height: circleRadius * 2)
                        .rotationEffect(.degrees(90))

                    // Eaten Calories (Green)
                    Circle()
                        .trim(from: 0.5, to: 0.5 + CGFloat(manager.totalCaloriesTaken) / CGFloat(dailyCalorieDeficit) / 2)
                        .stroke(style: StrokeStyle(lineWidth: 12, lineCap: .round, lineJoin: .round))
                        .foregroundColor(.green)
                        .frame(width: circleRadius * 2, height: circleRadius * 2)
                        .rotationEffect(.degrees(90))
                }
                
//                Text(getBottomIndicatorText())
//                    .font(.footnote)
//                    .foregroundColor(getIndicatorColor())
//
//                Text("Daily goal: \(Int(dailyCalorieDeficit)) cal")
//                    .font(.footnote)
//                    .foregroundColor(.primary)
//                
//                Text("Left to burn: \(Int(caloriesRemaining > 0 ? caloriesRemaining : 0)) cal")
//                    .font(.footnote)
//                    .foregroundColor(.primary)
            }
            .frame(width: circleRadius * 2, height: circleRadius * 2)
        }
        .padding()
    }

    func getBottomIndicatorText() -> String {
        switch petState {
        case .healthy:
            return "Doing great!"
        case .overweight:
            return "Move more!"
        case .underfed:
            return "Eat more!"
        }
    }

    func getIndicatorColor() -> Color {
        switch petState {
        case .healthy:
            return .green
        case .overweight:
            return .yellow
        case .underfed:
            return .red
        }
    }

    func getPetImageName() -> String {
        switch petState {
        case .healthy:
            return "puppy" // Energetic puppy
        case .overweight:
            return "puppy" // Overweight puppy
        case .underfed:
            return "puppy" // Underfed puppy
        }
    }
}

#Preview {
    CalorieProgressView()
        .environmentObject(HealthManager())
}
