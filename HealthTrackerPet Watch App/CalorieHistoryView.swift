// File: CalorieHistoryView.swift
import SwiftUI
import Charts

struct CalorieHistoryView: View {
    @EnvironmentObject var manager: HealthManager
    private let days = 7
    
    private var lastSevenDays: [(day: String, date: Date)] {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        return (0..<days).compactMap { dayOffset in
            let date = calendar.date(byAdding: .day, value: -dayOffset, to: Date())!
            return (dateFormatter.string(from: date), date)
        }.reversed()
    }
    
    private var calorieData: [(day: String, burned: Double, taken: Double)] {
        return lastSevenDays.enumerated().map { index, dayInfo in
            let burned = max(0, manager.getCaloriesBurned(for: days - index - 1))
            let taken = max(0, manager.getCaloriesTaken(for: days - index - 1))
            return (dayInfo.day, burned, taken)
        }
    }

    var body: some View {
        VStack {
            Text("Calorie History")
                .font(.headline)
                .foregroundColor(.customYellow)
                .padding(.top)

            Chart {
                ForEach(calorieData, id: \.day) { data in
                    BarMark(
                        x: .value("Day", data.day),
                        y: .value("Calories Taken", data.taken)
                    )
                    .foregroundStyle(.red)
                }
                
                ForEach(calorieData, id: \.day) { data in
                    LineMark(
                        x: .value("Day", data.day),
                        y: .value("Calories Burned", data.burned)
                    )
                    .foregroundStyle(.blue)
                    .lineStyle(StrokeStyle(lineWidth: 2))
                    .symbol(Circle())
                    .zIndex(1) // Ensure the line mark is above the bar mark
                }
            }
            .frame(height: 200)
            .padding(.horizontal)
            
            Text("Red Bars: Calories Taken")
                .font(.footnote)
                .foregroundColor(.red)
            
            Text("Blue Line: Calories Burned")
                .font(.footnote)
                .foregroundColor(.blue)
        }
        .padding()
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        )
    }
}

#Preview {
    CalorieHistoryView()
        .environmentObject(HealthManager())
}
