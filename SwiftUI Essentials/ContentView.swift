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
        VStack(spacing: 20) {
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
                .padding(.trailing, 20) // Adjust padding from the trailing edge
            }
            .padding(.leading, 20) // Adjust padding from the leading edge
            .padding(.top, 56)

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
                    .padding(.horizontal, 20) // Padding to match other content
            }

            HStack {
                Text("Progress")
                    .font(.system(size: 22))
                    .foregroundColor(colorScheme == .dark ? .white : .black) // Dynamic color
                    .padding(.top, 9)
                    .padding(.leading, 20) // Adjust padding to align with button
                Spacer() // This aligns the "Progress" text to the left
            }

            Rectangle()
                .fill(Color("Rectangle", bundle: nil)) // Use asset color with different appearances for light and dark mode
                .frame(width: UIScreen.main.bounds.width - 40, height: 139) // Adjust width to fill screen width with leading and trailing padding
                .cornerRadius(8)
                .overlay(
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Daily Task")
                            .font(.system(size: 18))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                        
                        Text("3/6 Task Completed")
                            .font(.system(size: 16))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding(.top, 9)
                        
                        HStack {
                            Text("Keep working")
                                .font(.system(size: 14))
                                .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.8) : Color.black.opacity(0.8))

                            
                            Spacer()
                            
                            Text("100%")
                                .padding(.leading, -30)
                                .font(.system(size: 18))
                                .frame(width: 37, height: 22)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }

                        
                        ProgressView(value: 0.5) // Adjust the progress value as needed
                            .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                            .frame(height: 6)
                            .padding(.top, 3)
                    }
                    .padding()
                )
                .padding(.leading, 20) // Adjust padding from the leading edge
                .padding(.trailing, 20) // Adjust padding from the trailing edge
                .padding(.top, 19)

            HStack {
                Text("Completed Tasks")
                    .font(.system(size: 22))
                    .foregroundColor(colorScheme == .dark ? .white : .black) // Dynamic color
                    .padding(.top, 30)
                    .padding(.leading, 20) // Adjust padding to align with button
                Spacer() // This aligns the "Progress" text to the left
            }
            Spacer() // This aligns the "Progress" text to the left

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
