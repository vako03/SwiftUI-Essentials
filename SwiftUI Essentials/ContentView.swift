//
//  ContentView.swift
//  SwiftUI Essentials
//
//  Created by valeri mekhashishvili on 24.05.24.
//
import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @State private var completedTasks = [("Mobile App Research", "4 Oct"), ("Prepare Wireframe for Main Flow", "4 Oct"), ("Prepare Screens", "4 Oct")]
    @State private var uncompletedTasks = [("Website Research", "5 Oct"), ("Prepare Wireframe for Main Flow", "5 Oct"), ("Prepare Screens", "5 Oct")]
    
    var body: some View {
        VStack(spacing: 20) {
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("You have \(uncompletedTasks.count) tasks \nto complete")
                        .font(.system(size: 25, weight: .bold))
                }
                Spacer()
                ZStack {
                    Image("ellipse")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 49, height: 49)
                    Image("image")
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
                .padding(.trailing, 20)
            }
            .padding(.leading, 20)
            .padding(.top, 56)
            
            Button(action: {
                completeAllTasks()
            }) {
                Text("Complete All")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(
                        LinearGradient(gradient: Gradient(colors: [
                            Color(#colorLiteral(red: 0.4509803922, green: 0.6705882353, blue: 1, alpha: 1)),
                            Color(#colorLiteral(red: 0.2745098039, green: 0.7529411765, blue: 0.7607843137, alpha: 1))
                        ]), startPoint: .leading, endPoint: .trailing)
                    )
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
            }
            
            HStack {
                Text("Progress")
                    .font(.system(size: 22))
                    .foregroundColor(colorScheme == .dark ? .white : .black)
                    .padding(.top, 9)
                    .padding(.leading, 20)
                Spacer()
            }
            
            ScrollView {
                VStack(spacing: 20) {
                    Rectangle()
                        .fill(Color("Rectangle", bundle: nil))
                        .frame(width: UIScreen.main.bounds.width - 40, height: 139)
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
                                
                                
                                ProgressView(value: Double(completedTasks.count) / Double(completedTasks.count + uncompletedTasks.count))
                                    .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                    .frame(height: 6)
                                    .padding(.top, 3)
                            }
                                .padding()
                        )
                        .padding(.leading, 20)
                        .padding(.trailing, 20)
                        .padding(.top, 19)
                    
                    HStack {
                        Text("Completed Tasks")
                            .font(.system(size: 22))
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .padding(.top, 30)
                            .padding(.leading, 20)
                        Spacer()
                    }
                    .padding(.bottom, 10)
                    
                    VStack(spacing: 0) {
                        ForEach(completedTasks, id: \.0) { task, date in
                            TaskCell(title: task, date: date, isCompleted: true, completedTasks: $completedTasks, uncompletedTasks: $uncompletedTasks)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 80)
                                .padding(.bottom, 5)
                        }
                        
                        Spacer().frame(height: 10)
                        
                        ForEach(uncompletedTasks, id: \.0) { task, date in
                            TaskCell(title: task, date: date, isCompleted: false, completedTasks: $completedTasks, uncompletedTasks: $uncompletedTasks)
                                .frame(width: UIScreen.main.bounds.width - 40, height: 80)
                                .padding(.bottom, 5)
                        }
                    }
                }
                .padding(.horizontal, 20)
            }
            
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
    var date: String
    var isCompleted: Bool
    @Binding var completedTasks: [(String, String)]
    @Binding var uncompletedTasks: [(String, String)]
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(title)
                    .font(.system(size: 16))
                HStack {
                    Image("calendar")
                        .resizable()
                        .frame(width: 15, height: 15)
                    Text(date) // Display the date
                        .font(.system(size: 12))
                }
            }
            Spacer()
            if isCompleted {
                Image("circle")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if let index = completedTasks.firstIndex(where: { $0.0 == title }) {
                            completedTasks.remove(at: index)
                            uncompletedTasks.append((title, date))
                        }
                    }
            } else {
                Image("Vector")
                    .resizable()
                    .frame(width: 26, height: 26)
                    .foregroundColor(.blue)
                    .onTapGesture {
                        if let index = uncompletedTasks.firstIndex(where: { $0.0 == title }) {
                            uncompletedTasks.remove(at: index)
                            completedTasks.append((title, date))
                        }
                    }
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 20)
        .background(Color("Rectangle", bundle: nil))
        .cornerRadius(8)
    }
}


#Preview {
    ContentView()
}
