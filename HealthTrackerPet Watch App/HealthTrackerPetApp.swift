//
//  HealthTrackerPetApp.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 20/05/24.
//

import SwiftUI

@main
struct HealthTrackerPetApp: App {
    @State private var selectedTab = 0
    var body: some Scene {
        WindowGroup {
//            TabView {
//                HomeView()
//                    .tabItem {
//                        Label("Home", systemImage: "house.fill")
//                    }
//                SummaryView()
//                    .tabItem {
//                        Label("Summary", systemImage: "list.star")
//                    }
//            }
            TabView(selection: $selectedTab) {
                        // Tab 1
                        NavigationView { // Add NavigationView to enable horizontal tab navigation
                            TabView {
                                HomeView()
                                    .tabItem {
                                        Label("Home", systemImage: "house.fill")
                                    }
                                    .tag(0)
                                SummaryView()
                                    .tabItem {
                                        Label("Summary", systemImage: "list.star")
                                    }
                                    .tag(1)
                            }
                            .tabViewStyle(.page(indexDisplayMode: .never)) // Horizontal tabs
                        }
                        .tag(0)
                        
                        CalorieHistoryView()
                            .tag(1)

                        // Tab 3
                        CalorieLogView()
                            .tag(2)
                    }
            .tabViewStyle(.verticalPage)
            .environmentObject(HealthManager())
        }
    }
}


