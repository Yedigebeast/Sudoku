//
//  ContentView.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    @State private var isPlayerTablePage = false
    
    var body: some View {
        if isPlayerTablePage == false {
            ZStack {
                Constants.primaryColor
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    switch selectedTab {
                    case 0:
                        MainPage(isPlayerTablePage: $isPlayerTablePage)
                    default:
                        StatisticsPage()
                    }
                    TabBottomView(selectedIndex: $selectedTab, tabbarItems: [
                        TabItemData(image: "house", title: "Main", index: 0),
                        TabItemData(image: "chart.bar.xaxis", title: "Statistics", index: 1),
                    ])
                }
            }
        } else {
            PlayerTablePage(isPlayerTablePage: $isPlayerTablePage)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
