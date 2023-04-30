//
//  SudokuDataModel.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import SwiftUI

struct element {
    var index: Int
    var number: Int
}

class SudokuModel: ObservableObject {
    
    @Published var selection = gameDifficulty.none
    @Published var selectedCell = 0
    @Published var selectedNumber = 0
    
    @Published var isStarted = false
    @Published var isFinished = false
    @Published var isWin = false
    
    @Published var date = Date()
    @Published var time = 0
    @Published var mistakes = 0
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var lastSteps: [element] = []
    @Published var numbers = Array.init(repeating: 0, count: 81)
    @Published var robotPut = Array.init(repeating: false, count: 81)
    @Published var cellColor = Array.init(repeating: Color.white, count: 81)
    @Published var numberColor = Array.init(repeating: Color.black, count: 81)

    private let nineSquares = [
        [0, 1, 2,  9, 10, 11, 18, 19, 20],
        [3, 4, 5, 12, 13, 14, 21, 22, 23],
        [6, 7, 8, 15, 16, 17, 24, 25, 26],
        
        [27, 28, 29, 36, 37, 38, 45, 46, 47],
        [30, 31, 32, 39, 40, 41, 48, 49, 50],
        [33, 34, 35, 42, 43, 44, 51, 52, 53],
        
        [54, 55, 56, 63, 64, 65, 72, 73, 74],
        [57, 58, 59, 66, 67, 68, 75, 76, 77],
        [60, 61, 62, 69, 70, 71, 78, 79, 80]
    ]
    
    func activateTheTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func stopTheTimer() {
        time = 0
        timer.upstream.connect().cancel()
    }
    
    func addNumbersToArray() {
        for i in (0...80) {
            numbers[i] = 0
        }
        
        if selection == .easy {
            colorElementsRandomly(quantity: 42)
        }
    }
    
    private func colorElementsRandomly(quantity: Int) {
        var count = 0
        while count < quantity {
            var container = 0
            while 1 == 1 {
                container = Int.random(in: 0...8)
                var kol = 0
                for i in 0...8 {
                    if numbers[nineSquares[container][i]] != 0 {
                        kol += 1
                    }
                }
                var couldPut = false
                if kol <= quantity / 9 {
                    var a: [element] = []
                    for index in 0...8 {
                        for number in 1...9 {
                            if numbers[nineSquares[container][index]] == 0 {
                                if checkIfHave(number: number, index: nineSquares[container][index]) == false {
                                    a.append(element(index: nineSquares[container][index], number: number))
                                }
                            }
                        }
                    }
                    
                    if a.count >= 1 {
                        let rnd = Int.random(in: 0...(a.count - 1))
                        numbers[a[rnd].index] = a[rnd].number
                        robotPut[a[rnd].index] = true
                        couldPut = true
                        count += 1
                        break
                    }
                }
                if couldPut == true {
                    break
                }
            }
        }
    }
    
    private func checkIfHave(number: Int, index: Int) -> Bool {
        var have = false
        for i in 0...8 {
            if nineSquares[i].contains(index) == true {
                for j in 0...8 {
                    if numbers[nineSquares[i][j]] == number {
                        have = true
                    }
                }
            }
        }
        for i in ((index / 9) * 9)..<((index / 9 + 1) * 9) {
            if numbers[i] == number {
                have = true
            }
        }
        var j = index % 9
        while (j < 81) {
            if numbers[j] == number {
                have = true
            }
            j += 9
        }
        return have
    }
    
    func userPressedCell(by index: Int) {
        selectedCell = index
        selectedNumber = 0
        
        for i in 0..<cellColor.count {
            cellColor[i] = .white
        }
        
        for i in 0...8 {
            if nineSquares[i].contains(index) == true {
                for j in 0...8 {
                    cellColor[nineSquares[i][j]] = .cyan.opacity(0.6)
                }
            }
        }
        for i in ((index / 9) * 9)..<((index / 9 + 1) * 9) {
            cellColor[i] = .cyan.opacity(0.6)
        }
        var j = index % 9
        while (j < 81) {
            cellColor[j] = .cyan.opacity(0.6)
            j += 9
        }
        
        if numbers[index] != 0 {
            for i in 0...80 {
                if numbers[i] == numbers[index] {
                    cellColor[i] = .blue
                }
            }
        }
        cellColor[index] = .green
        
    }
    
    func userPressedNumber(by number: Int){
        selectedNumber = number
        if robotPut[selectedCell] == true {
            return
        }
        for i in 0..<lastSteps.count {
            if lastSteps[i].index == selectedCell {
                lastSteps.remove(at: i)
                break
            }
        }
        lastSteps.append(element(index: selectedCell, number: selectedNumber))
        numberColor[selectedCell] = .red
        numbers[selectedCell] = selectedNumber
    }
    
    func undoButtonPressed() {
        if let lastElement = lastSteps.last {
            numbers[lastElement.index] = 0
            numberColor[lastElement.index] = .black
            lastSteps.remove(at: lastSteps.count - 1)
            userPressedCell(by: lastElement.index)
        }
    }
    
    func eraseButtonPressed() {
        if numbers[selectedCell] != 0 && numberColor[selectedCell] != .black {
            for i in 0..<lastSteps.count {
                if lastSteps[i].index == selectedCell {
                    lastSteps.remove(at: i)
                    break
                }
            }
            numbers[selectedCell] = 0
            numberColor[selectedCell] = .black
            userPressedCell(by: selectedCell)
        }
    }
    
}

