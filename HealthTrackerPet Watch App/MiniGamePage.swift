//
//  MiniGamePage.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 25/05/24.
//

import SwiftUI

struct MiniGamePage: View {
    var body: some View {
        NavigationStack {
            VStack {
                Text("Play Mini Game")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()

                Spacer()

                NavigationLink(destination: MiniGameSelectionPage()) {
                    Image(systemName: "play.circle.fill")
                        .foregroundColor(.customYellow)
                        .font(.system(size: 40))
                }
                .padding(.horizontal)
                .padding(.horizontal)
                .padding(.horizontal)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                LinearGradient(gradient: Gradient(colors: [.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
            )
            .navigationBarHidden(true)
        }
    }
}

#Preview {
    MiniGamePage()
}
