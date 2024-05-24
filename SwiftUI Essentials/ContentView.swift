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
                    Text("You have 3 tasks \n to complete")
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
            
            Spacer().frame(height: 35) // Spacer to create a space of 35 points
            
            Button(action: {
                // Action when "Complete All" button is tapped
            }) {
                Text("Complete All")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(.white)
                    .frame(width: 365, height: 50) // Button size
                    .background(Color.blue)
                    .cornerRadius(8)
            }
            .padding(.horizontal, 20)
            
            Spacer()
        }
        .background(backgroundTintColor)
    }
    
    var backgroundTintColor: Color {
        if colorScheme == .dark {
            // Use dark mode background color
            return Color.black
        } else {
            // Use light mode background color
            return Color("background")
        }
    }
}

#Preview {
    ContentView()
}

//                .padding(.top, -600)
