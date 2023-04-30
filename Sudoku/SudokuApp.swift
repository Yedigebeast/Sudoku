//
//  SudokuApp.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import SwiftUI

@main
struct SudokuApp: App {
    @StateObject private var sudokuModel = SudokuModel()
    @StateObject private var statistics = Statistics()
    @StateObject private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(sudokuModel)
                .environmentObject(statistics)
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
