//
//  HomeView.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 20/05/24.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var manager: HealthManager
    var body: some View {
        ZStack { // Use ZStack for layering elements
            LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                HStack {
                    Image(systemName: "flame")
                           .font(.headline)
                           .foregroundColor(.white)

                       Text("\(Int(manager.calories)) / 10000")
                           .font(.headline)
                           .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "figure.walk")
                           .font(.headline)
                           .foregroundColor(.white)
                    
                    Text("Steps: \(Int(manager.steps)) / 9000")  // Updated label
                        .font(.headline)
                        .foregroundColor(.white)
                }
                .padding(.horizontal)

                Spacer() // Push image and buttons down

                Image(systemName: "pawprint.fill") // Example system image
                    .font(.system(size: 70))
                    .foregroundColor(.white)
                    .padding(20) // Adjust padding as needed

                HStack {
                    Spacer()
                    Button(action: {}) { // Placeholder action
                        Image(systemName: "play.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }

                    Spacer() // Space between buttons

                    Button(action: {}) { // Placeholder action
                        Image(systemName: "plus.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                    Spacer()
                }
                
            }
        }
        .onAppear { // Fetch data when view appears
            manager.fetchHealthData()
        }
    }
}

#Preview {
    HomeView()
}
