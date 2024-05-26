// File: MiniGameSelectionPage.swift
import SwiftUI

struct MiniGameSelectionPage: View {
    let miniGames = [
        ("Jump Rope Game", "figure.walk"),
        ("Game 2", "gamecontroller.fill"),
        ("Game 3", "gamecontroller.fill")
    ] // Placeholder for mini games

    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                ForEach(miniGames, id: \.0) { game in
                    NavigationLink(destination: getGameView(for: game.0)) {
                        MiniGameCard(gameName: game.0, icon: game.1)
                    }
                }
            }
            .padding()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(
            LinearGradient(gradient: Gradient(colors: [.black, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
        )
        .navigationBarHidden(true)
    }
    
    func getGameView(for gameName: String) -> some View {
        switch gameName {
        case "Jump Rope Game":
            return AnyView(JumpRopeGameView())
        case "Game 2":
            // Replace with actual view for Game 2
            return AnyView(Text("Game 2 View"))
        case "Game 3":
            // Replace with actual view for Game 3
            return AnyView(Text("Game 3 View"))
        default:
            return AnyView(Text("Unknown Game"))
        }
    }
}

#Preview {
    MiniGameSelectionPage()
}
