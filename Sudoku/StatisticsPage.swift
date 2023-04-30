//
//  StatisticsPage.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import SwiftUI

struct StatisticsPage: View {
    private var tabs = ["Easy", "Medium", "Hard", "Expert", "Evil"]
    @State private var selectedTab = "Easy"
    
    @EnvironmentObject var statisticsModel: StatisticsModel
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var items: FetchedResults<Item>

    var body: some View {
        VStack {
            Text("Statistics")
                .font(.custom(Constants.bold, size: 22))
            
            Picker("Please Choose a Difficulty Level", selection: $selectedTab) {
                ForEach(tabs, id: \.self) {tab in
                    Text(tab)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            
            statisticsView
            
            Spacer()
        }
        .onChange(of: selectedTab, perform: { newValue in
            calculateStatistics()
        })
        .onAppear {
            calculateStatistics()
        }
    }
    
    private func calculateStatistics() {
        statisticsModel.reset()
        for i in items {
            if i.difficulty == selectedTab {
                statisticsModel.games += 1
                if i.isWin == true {
                    statisticsModel.wins += 1
                    statisticsModel.winsWithNoMistakes += (i.mistakes == 0 ? 1 : 0)
                    
                    if statisticsModel.bestTime == 0 {
                        statisticsModel.bestTime = Int(i.time)
                    }
                    statisticsModel.bestTime = min(statisticsModel.bestTime, Int(i.time))
                    statisticsModel.averageTime += Int(i.time)
                }
            }
        }
        var x: Double = Double(statisticsModel.wins)
        if (statisticsModel.games != 0) {
            x = x / Double(statisticsModel.games)
            x *= 100
        }
        statisticsModel.winRate = Double(round(10 * x) / 10)
        
        x = Double(statisticsModel.averageTime)
        if statisticsModel.wins != 0 {
            x = x / Double(statisticsModel.wins)
        }
        statisticsModel.averageTime = Int(round(x))
        
        x = 0
        for i in items {
            if i.difficulty == selectedTab {
                if i.isWin == false {
                    break
                }
                x += 1
            }
        }
        
        statisticsModel.currentWinStreak = Int(x)
        
        var ans = 0
        x = 0
        for i in items {
            if i.difficulty == selectedTab {
                if i.isWin == false {
                    ans = max(ans, Int(x))
                    x = 0
                }
                else {
                    x += 1
                }
            }
        }
        statisticsModel.bestWinStreak = max(ans, Int(x))
    }
    
    var statisticsView: some View {
        ScrollView {
            Group {
                Text("Games")
                    .font(.custom(Constants.semibold, size: 25))
                    .padding(.bottom, 10)
                customRectangleText(text1: "Games Played", text2: "\(statisticsModel.games)")
                customRectangleText(text1: "Games Won", text2: "\(statisticsModel.wins)")
                customRectangleText(text1: "Win Rate", text2: "\(statisticsModel.winRate)%")
                customRectangleText(text1: "Wins with No Mistakes", text2: "\(statisticsModel.winsWithNoMistakes)")
                
                Spacer()
                    .frame(height: 20)
                
                Text("Time")
                    .font(.custom(Constants.semibold, size: 25))
                    .padding(.bottom, 10)
                customRectangleText(text1: "Best Time", text2: getTimeFromInt(count: statisticsModel.bestTime))
                customRectangleText(text1: "Average Time", text2: getTimeFromInt(count: statisticsModel.averageTime))
                
            }
            
            Group {
                
                Spacer()
                    .frame(height: 20)
                
                Text("Streaks")
                    .font(.custom(Constants.semibold, size: 25))
                    .padding(.bottom, 10)
                customRectangleText(text1: "Current Win Streak", text2: "\(statisticsModel.currentWinStreak)")
                customRectangleText(text1: "Best Win Streak", text2: "\(statisticsModel.bestWinStreak)")
                
            }
            
        }
        .scrollIndicators(.hidden)
        .padding()
    }
    
}

fileprivate struct customRectangleText: View {
    var text1: String
    var text2: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(.cyan.opacity(0.4))
                .frame(height: 80)
            HStack {
                Text(text1)
                Spacer()
                Text(text2)
            }
            .font(.custom(Constants.semibold, size: 18))
            .padding()
        }
    }
}

struct StatisticsPage_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsPage()
    }
}
