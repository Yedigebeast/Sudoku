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
    
    var body: some View {
        Text("Statistics")
            .font(.custom(Constants.bold, size: 22))
        
        Picker("Please Choose a Difficulty Level", selection: $selectedTab) {
            ForEach(tabs, id: \.self) {tab in
                Text(tab)
            }
        }
        .pickerStyle(.segmented)
        .padding()
        
        Spacer()
    }
}

struct StatisticsPage_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsPage()
    }
}
