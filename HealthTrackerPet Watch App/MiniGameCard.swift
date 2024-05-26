// File: MiniGameCard.swift
import SwiftUI

struct MiniGameCard: View {
    let gameName: String
    let icon: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) { // Adjust spacing for better visual balance
            HStack {
                Image(systemName: icon)
                    .font(.system(size: 24, weight: .bold))
                Text(gameName)
                    .font(.headline)
            }
            .foregroundColor(.white)
            
            Spacer()
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 15)
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [.blue, .purple]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
        )
        .frame(maxWidth: .infinity, minHeight: 100) // Ensure the card is large enough for easy tapping
    }
}

#Preview {
    MiniGameCard(gameName: "Jump Rope Game", icon: "figure.walk")
}
