//
//  CalorieLogView.swift
//  HealthTrackerPet Watch App
//
//  Created by Anthony on 26/05/24.
//

import SwiftUI

struct CalorieLogView: View {
    @EnvironmentObject var manager: HealthManager

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        return formatter
    }

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Today")
                    .font(.headline)
                    .foregroundColor(.customYellow)
                    .padding(.trailing)
            }
            .padding(.top, 10)

            List {
                ForEach(manager.calorieLog, id: \.id) { log in
                    HStack {
                        VStack(alignment: .leading) {
                            HStack{
                                Image(systemName: "fork.knife")
                                    .foregroundColor(/*@START_MENU_TOKEN@*/.blue/*@END_MENU_TOKEN@*/)
                                Text(dateFormatter.string(from: log.date))
                                    .font(.headline)
                                    .foregroundColor(.white)
                                
                            }
                            
                            
                            Text("\(Int(log.calories)) cal")
                                .font(.subheadline)
                                .foregroundColor(.customYellow)
                        }
                        Spacer()
                    }
                    .padding()
                }
            }
        }
        .navigationTitle("Calorie Log")
    }
}

#Preview {
    CalorieLogView()
        .environmentObject(HealthManager())
}
