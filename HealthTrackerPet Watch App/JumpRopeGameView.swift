//
//  JumpRopeGameView.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 25/05/24.
//

import SwiftUI

struct JumpRopeGameView: View {
    @EnvironmentObject var manager: HealthManager
    @State private var goal: Int = 100
    @State private var jumps: Int = 0
    @State private var caloriesBurned: Double = 0.0
    @State private var isGameActive = false

    var body: some View {
        VStack {
            if !isGameActive {
                VStack {
                    Text("Set Your Jump Rope Goal")
                        .font(.title2)
                        .padding()

                    Stepper("Goal: \(goal) jumps", value: $goal, in: 10...1000, step: 10)
                        .padding()

                    Button(action: startGame) {
                        Text("Start Jump Rope")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.green)
                            .cornerRadius(10)
                    }
                }
            } else {
                VStack {
                    Text("Jump Rope Game")
                        .font(.largeTitle)
                        .padding()

                    Text("Jumps: \(jumps) / \(goal)")
                        .font(.headline)
                        .padding()

                    Text("Calories Burned: \(caloriesBurned, specifier: "%.2f")")
                        .font(.headline)
                        .padding()

                    Image("dog-jumping") // Use a stock photo for now
                        .resizable()
                        .frame(width: 120, height: 120)
                        .aspectRatio(contentMode: .fit)

                    Spacer()

                    Button(action: stopGame) {
                        Text("Stop Game")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.red)
                            .cornerRadius(10)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        )
        .onAppear {
            manager.fetchHealthData()
        }
    }

    func startGame() {
        isGameActive = true
        jumps = 0
        caloriesBurned = 0.0
        manager.startJumpRopeSession()
        // Here you would start monitoring the sensor data to detect jumps
    }

    func stopGame() {
        isGameActive = false
        manager.stopJumpRopeSession()
        // Here you would stop monitoring the sensor data
    }

    func detectJump() {
        jumps += 1
        let caloriesPerJump = 0.1 // Example value, adjust based on actual calculation
        caloriesBurned += caloriesPerJump
        manager.updateCaloriesBurned(calories: caloriesPerJump)
    }
}

#Preview {
    JumpRopeGameView()
}
