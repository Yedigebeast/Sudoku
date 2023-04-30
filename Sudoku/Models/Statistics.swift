//
//  Statistics.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 30.04.2023.
//

import SwiftUI

class Statistics: ObservableObject {
    
    @Published var games = 0
    @Published var wins = 0
    @Published var winRate = 0.0
    @Published var winsWithNoMistakes = 0
    
    @Published var bestTime = 0
    @Published var averageTime = 0
    
    @Published var currentWinStreak = 0
    @Published var bestWinStreak = 0

    func reset() {
        games = 0
        wins = 0
        winRate = 0.0
        winsWithNoMistakes = 0
        
        bestTime = 0
        averageTime = 0
        
        currentWinStreak = 0
        bestWinStreak = 0
    }
    
}

