//
//  HomeView.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 20/05/24.
//

import SwiftUI

extension Color {
    static let customYellow = Color(red: 255 / 255, green: 207 / 255, blue: 122 / 255)
}

struct HomeView: View {
    
    @EnvironmentObject var manager: HealthManager
    @State private var showCalorieInput = false
    @State private var manualCalories = 0.0

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Goldy")
                        .foregroundColor(.customYellow)
                        .font(.system(size: 20))
                    Spacer()
                }
                .padding(.horizontal)

                CalorieProgressView()

                Spacer()

                HStack {
                    NavigationLink(destination: MiniGamePage()) {
                        Image(systemName: "play.circle.fill")
                            .foregroundColor(.customYellow)
                            .font(.system(size: 22))
                    }
                    Spacer()
                    Button(action: {
                        showCalorieInput = true
                    }) {
                        Image(systemName: "fork.knife")
                            .foregroundColor(.customYellow)
                            .font(.system(size: 22))
                    }
                    .sheet(isPresented: $showCalorieInput) {
                        VStack {
                            Text("Enter Calories")
                                .font(.headline)
                                .padding()

                            Stepper("Calories: \(Int(manualCalories))", value: $manualCalories, in: 0...10000, step: 50)
                                .padding()
                                .background(Color(.gray))
                                .cornerRadius(10)
                                .padding(.horizontal)

                            Button("Add") {
                                manager.updateManualCaloriesTaken(calories: manualCalories)
                                showCalorieInput = false
                                manualCalories = 0.0
                            }
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .padding()
                    }
                }
                .padding(.bottom, 10)
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .onAppear {
                manager.fetchHealthData()
                            }
                        }
                    }
                }

#Preview {
    HomeView()
        .environmentObject(HealthManager())
}

