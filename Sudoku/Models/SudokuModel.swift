//
//  SudokuDataModel.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import SwiftUI

class SudokuModel: ObservableObject {
    @Published var lastGameTime: Int = 100
    @Published var lastGameDifficulty: gameDifficulty = .easy
    @Published var selection = gameDifficulty.none
    @Published var isStarted = false
    @Published var isFinished = false
    @Published var isWin = false
    @Published var date = Date()
    @Published var time = 0
    @Published var mistakes = 0
    @Published var numbers = Array.init(repeating: 0, count: 81)
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var textForContinueLastGameButton: some View {
        HStack {
            Image(systemName: "timer")
            Text("\(getTimeFromInt(count: lastGameTime)) - \(lastGameDifficulty.rawValue)")
        }
        .foregroundColor(.white.opacity(0.4))
        .font(.custom(Constants.regular, size: 14))
    }
    
    func activateTheTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func pauseTheTimer() {
        timer.upstream.connect().cancel()
    }
    
    func stopTheTimer() {
        timer.upstream.connect().cancel()
    }
    
}

