////
////  TestUI.swift
////  HealthTrackerPet Watch App
////
////  Created by Anthony on 25/05/24.
////
//
//import SwiftUI
//
//extension Color {
//    static let customYellow = Color(red: 255 / 255, green: 207 / 255, blue: 122 / 255)
//}
//
//struct TestUI: View {
//    @EnvironmentObject var manager: HealthManager
//    var body: some View {
//        ZStack{
//            LinearGradient(gradient: Gradient(colors: [.black]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .ignoresSafeArea()
//            
//            VStack{
//                HStack {
//                    Text("Goldy")
//                        .foregroundColor(.white)
//                        .font(.system(size: 20))
//                    Spacer()
//                    Text("\(Int(manager.calories))")
//                        .font(.system(size: 20))
//                }
//                .padding(.horizontal)
//                
//                HStack{
//                    Text("Healthy")
//                        .foregroundColor(.customYellow)
//                        .font(.system(size: 20))
//                    Spacer()
//                    Image(systemName: "flame")
//                        .foregroundColor(.customYellow)
//                        .font(.system(size: 20))
//                }
//                .padding(.horizontal)
//                
//                Image("puppy")
//                    .resizable()
//                    .frame(width: 120, height: 120)
//                    .aspectRatio(contentMode: .fit)
//                
//                Spacer()
//                HStack {
//                    Button(action: {
//                        // Action for the left button
//                    }) {
//                        Image(systemName: "play.circle.fill") .foregroundColor(.customYellow)
//                            .font(.system(size: 24))
//                    }
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    Spacer()
//                    
//                    Button(action: {
//                        // Action for the right button
//                    }) {
//                        Image(systemName: "fork.knife") .foregroundColor(.customYellow)
//                            .font(.system(size: 24))
//                    }
//                }
//                .padding(.bottom, 20)
//                .padding(.horizontal)
//            }
//            
//                
//            }
//        .onAppear { // Fetch data when view appears
//            manager.fetchHealthData()
//        }
//    }
//}
//
//#Preview {
//    TestUI()
//}
