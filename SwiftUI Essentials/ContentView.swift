//
//  ContentView.swift
//  SwiftUI Essentials
//
//  Created by valeri mekhashishvili on 24.05.24.
//
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("You have 3 tasks \nto complete")
                        .font(.system(size: 25, weight: .bold))
                }
                Spacer()
                ZStack {
                    Image("ellipse") // Overlay image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 49, height: 49)
                    Image("image") // Background image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 44, height: 45)
                    Circle()
                        .fill(Color(#colorLiteral(red: 1, green: 0.4588235294, blue: 0.231372549, alpha: 1)))
                        .frame(width: 15, height: 15)
                        .overlay(
                            Text("3")
                                .font(.system(size: 9))
                                .foregroundColor(.white)
                        )
                        .offset(x: 15, y: 20)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 56)

            Spacer().frame(height: 35)

            Button(action: {
                // Action for button tap
            }) {
                Text("Complete All")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50) // Stretch to fill available width
                    .background(
                        LinearGradient(gradient: Gradient(colors: [
                            Color(#colorLiteral(red: 0.4509803922, green: 0.6705882353, blue: 1, alpha: 1)),
                            Color(#colorLiteral(red: 0.2745098039, green: 0.7529411765, blue: 0.7607843137, alpha: 1))
                        ]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
                    .padding(.horizontal, 16) // Padding to match other content
            }

            HStack {
                Text("Progress")
                    .font(.system(size: 22))
                    .foregroundColor(colorScheme == .dark ? .white : .black) // Dynamic color
                    .padding(.top, 19)
                Spacer() // This aligns the "Progress" text to the left
            }
            .padding(.horizontal, 20) // Aligns with the other content's padding
            
            Spacer()
        }
        .background(backgroundTintColor)
    }

    var backgroundTintColor: Color {
        if colorScheme == .dark {
            return Color.black
        } else {
            return Color("background")
        }
    }
}

#Preview {
    ContentView()
}
