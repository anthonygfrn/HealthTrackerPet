//
//  HealthTrackerPetApp.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 20/05/24.
//

import SwiftUI

@main
struct HealthTrackerPetApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house.fill")
                    }
                SummaryView()
                    .tabItem {
                        Label("Summary", systemImage: "list.star")
                    }
            }
            .environmentObject(HealthManager()) 
        }
    }
}
