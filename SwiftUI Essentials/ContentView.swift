//
//  ContentView.swift
//  SwiftUI Essentials
//
//  Created by valeri mekhashishvili on 24.05.24.
//
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var completedTasks = ["Mobile App Research", "Prepare Wireframe for Main Flow", "Prepare Screens"]
    @State private var uncompletedTasks = ["Website Research", "Prepare Wireframe for Main Flow", "Prepare Screens"]

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("You have \(uncompletedTasks.count) tasks \nto complete")
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
                            Text("\(uncompletedTasks.count)")
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
                completeAllTasks()
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
                        
                        Text("\(completedTasks.count)/\(completedTasks.count + uncompletedTasks.count) Task Completed")
                            .font(.system(size: 16))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding(.top, 9)
                        
                        HStack {
                            Text("Keep working")
                                .font(.system(size: 14))
                                .foregroundColor(colorScheme == .dark ? Color.white.opacity(0.8) : Color.black.opacity(0.8))

                            
                            Spacer()
                            
                            Text("\(percentageCompleted())%")
                                .padding(.leading, -30)
                                .font(.system(size: 18))
                                .frame(width: 37, height: 22)
                                .foregroundColor(colorScheme == .dark ? .white : .black)
                        }

                        
                        ProgressView(value: Double(completedTasks.count) / Double(completedTasks.count + uncompletedTasks.count)) // Adjust the progress value as needed
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
            .padding(.bottom, 10)
            
            ScrollView {
                VStack(spacing: 0) {
                    ForEach(completedTasks, id: \.self) { task in
                        TaskCell(title: task, isCompleted: true, completedTasks: $completedTasks, uncompletedTasks: $uncompletedTasks)
                            .frame(width: 390, height: 80)
                            .background(Color("Rectangle", bundle: nil))
                            .padding(.bottom, 5) // Add bottom padding to marked cells
                    }
                    
                    Spacer().frame(height: 10) // Add spacing between different types of cells
                    
                    ForEach(uncompletedTasks, id: \.self) { task in
                        TaskCell(title: task, isCompleted: false, completedTasks: $completedTasks, uncompletedTasks: $uncompletedTasks)
                            .frame(width: 390, height: 80)
                            .background(Color("Rectangle", bundle: nil))
                            .padding(.bottom, 5) // Add bottom padding to unmarked cells
                    }
                }
                .padding(.horizontal, 20)
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
    
    func completeAllTasks() {
        completedTasks.append(contentsOf: uncompletedTasks)
        uncompletedTasks.removeAll()
    }

    func percentageCompleted() -> Int {
        let totalTasks = completedTasks.count + uncompletedTasks.count
        if totalTasks > 0 {
            return Int(Double(completedTasks.count) / Double(totalTasks) * 100)
        } else {
            return 0
        }
    }
}

struct TaskCell: View {
    var title: String
    var isCompleted: Bool
    @Binding var completedTasks: [String]
    @Binding var uncompletedTasks: [String]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 16))
                Image("calendar")
                    .resizable()
                    .frame(width: 15, height: 15)
            }
            Spacer()
            if isCompleted {
                Image(systemName: "checkmark.circle.fill")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .foregroundColor(.blue)
                    .onTapGesture { // Toggle completion status
                        if let index = completedTasks.firstIndex(of: title) {
                            completedTasks.remove(at: index)
                            uncompletedTasks.append(title)
                        }
                    }
            } else {
                Image(systemName: "circle")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .foregroundColor(.blue)
                    .onTapGesture { // Toggle completion status
                        if let index = uncompletedTasks.firstIndex(of: title) {
                            uncompletedTasks.remove(at: index)
                            completedTasks.append(title)
                        }
                    }
            }
        }
        .padding(.vertical, 10) // Adjust vertical padding
        .padding(.horizontal, 20) // Adjust horizontal padding
    }
}
#Preview {
    ContentView()
}
