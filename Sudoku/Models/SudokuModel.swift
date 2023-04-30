//
//  SudokuDataModel.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import SwiftUI
import CoreData

struct element {
    var index: Int
    var number: Int
}

class SudokuModel: ObservableObject {
    
    @Published var selection = gameDifficulty.none
    @Published var selectedCell = 0
    @Published var selectedNumber = 0
    
    @Published var selectingNumberBlocked = false
    
    @Published var time = 0
    @Published var mistakes = 0
    @Published var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @Published var lastSteps: [element] = []
    @Published var numbers = Array.init(repeating: 0, count: 81)
    @Published var robotPut = Array.init(repeating: false, count: 81)
    @Published var cellColor = Array.init(repeating: Color.white, count: 81)
    @Published var numberColor = Array.init(repeating: Color.black, count: 81)
    @Published var solution = Array.init(repeating: 0, count: 81)

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
    
    func reset() {
        selectedCell = 0
        selectedNumber = 0
        time = 0
        
        mistakes = 0
        selectingNumberBlocked = false
        
        lastSteps = []
        numbers = Array.init(repeating: 0, count: 81)
        robotPut = Array.init(repeating: false, count: 81)
        cellColor = Array.init(repeating: Color.white, count: 81)
        numberColor = Array.init(repeating: Color.black, count: 81)
        solution = Array.init(repeating: 0, count: 81)
    }
    
    func activateTheTimer() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func stopTheTimer() {
        timer.upstream.connect().cancel()
    }
    
    func addNumbersToArray() {
        for i in (0...80) {
            numbers[i] = 0
        }
        
        if selection == .easy {
            numbers = [
                0, 9, 2, 4, 3, 8, 5, 6, 7,
                5, 4, 3, 6, 9, 7, 2, 8, 1,
                7, 6, 8, 5, 2, 1, 3, 4, 9,
                4, 3, 5, 9, 1, 2, 8, 7, 6,
                9, 2, 1, 7, 8, 6, 4, 3, 5,
                6, 8, 7, 3, 4, 5, 1, 9, 2,
                2, 5, 6, 8, 7, 3, 9, 1, 4,
                8, 1, 4, 2, 6, 9, 7, 5, 3,
                3, 7, 9, 1, 5, 4, 6, 2, 8
            ]
            
            solution = [
                1, 9, 2, 4, 3, 8, 5, 6, 7,
                5, 4, 3, 6, 9, 7, 2, 8, 1,
                7, 6, 8, 5, 2, 1, 3, 4, 9,
                4, 3, 5, 9, 1, 2, 8, 7, 6,
                9, 2, 1, 7, 8, 6, 4, 3, 5,
                6, 8, 7, 3, 4, 5, 1, 9, 2,
                2, 5, 6, 8, 7, 3, 9, 1, 4,
                8, 1, 4, 2, 6, 9, 7, 5, 3,
                3, 7, 9, 1, 5, 4, 6, 2, 8
            ]
        }
        
        if selection == .medium {
            numbers = [
                9, 0, 6, 4, 0, 0, 0, 5, 0,
                0, 5, 4, 3, 0, 6, 2, 0, 0,
                0, 0, 3, 0, 5, 2, 9, 4, 0,
                6, 8, 0, 0, 0, 5, 0, 9, 0,
                0, 0, 5, 0, 0, 0, 6, 0, 0,
                0, 9, 0, 1, 0, 0, 0, 8, 2,
                0, 7, 1, 6, 8, 0, 3, 0, 0,
                0, 0, 9, 2, 0, 3, 7, 1, 0,
                0, 3, 0, 0, 0, 7, 4, 0, 9
            ]
            
            solution = [
                9, 2, 6, 4, 7, 1, 8, 5, 3,
                8, 5, 4, 3, 9, 6, 2, 7, 1,
                7, 1, 3, 8, 5, 2, 9, 4, 6,
                6, 8, 2, 7, 3, 5, 1, 9, 4,
                1, 4, 5, 9, 2, 8, 6, 3, 7,
                3, 9, 7, 1, 6, 4, 5, 8, 2,
                4, 7, 1, 6, 8, 9, 3, 2, 5,
                5, 6, 9, 2, 4, 3, 7, 1, 8,
                2, 3, 8, 5, 1, 7, 4, 6, 9
            ]
        }
        
        if selection == .hard {
            numbers = [
                5, 0, 0, 0, 0, 0, 0, 0, 0,
                0, 8, 3, 1, 7, 0, 0, 0, 0,
                4, 0, 7, 0, 5, 0, 2, 0, 0,
                2, 0, 0, 0, 0, 0, 3, 0, 0,
                8, 0, 0, 7, 0, 9, 0, 0, 6,
                0, 0, 1, 0, 0, 0, 0, 0, 9,
                0, 0, 2, 0, 4, 0, 9, 0, 3,
                0, 0, 0, 0, 8, 1, 4, 6, 0,
                0, 0, 0, 0, 0, 0, 0, 0, 7
            ]
            
            solution = [
                5, 2, 6, 4, 9, 8, 7, 3, 1,
                9, 8, 3, 1, 7, 2, 6, 4, 5,
                4, 1, 7, 6, 5, 3, 2, 9, 8,
                2, 7, 9, 8, 6, 5, 3, 1, 4,
                8, 3, 4, 7, 1, 9, 5, 2, 6,
                6, 5, 1, 2, 3, 4, 8, 7, 9,
                1, 6, 2, 5, 4, 7, 9, 8, 3,
                7, 9, 5, 3, 8, 1, 4, 6, 2,
                3, 4, 8, 9, 2, 6, 1, 5, 7
            ]
        }
        
        if selection == .expert {
            numbers = [
                1, 0, 0, 0, 8, 0, 0, 0, 0,
                0, 0, 0, 0, 0, 3, 1, 9, 0,
                0, 0, 9, 0, 0, 2, 0, 8, 0,
                0, 4, 0, 7, 5, 0, 3, 6, 1,
                0, 0, 1, 0, 2, 0, 5, 0, 0,
                7, 6, 5, 0, 1, 4, 0, 2, 0,
                0, 5, 0, 2, 0, 0, 4, 0, 0,
                0, 2, 7, 8, 0, 0, 0, 0, 0,
                0, 0, 0, 0, 6, 0, 0, 0, 8
            ]
            
            solution = [
                1, 3, 2, 9, 8, 6, 7, 4, 5,
                6, 8, 4, 5, 7, 3, 1, 9, 2,
                5, 7, 9, 1, 4, 2, 6, 8, 3,
                2, 4, 8, 7, 5, 9, 3, 6, 1,
                3, 9, 1, 6, 2, 8, 5, 7, 4,
                7, 6, 5, 3, 1, 4, 8, 2, 9,
                8, 5, 6, 2, 9, 1, 4, 3, 7,
                4, 2, 7, 8, 3, 5, 9, 1, 6,
                9, 1, 3, 4, 6, 7, 2, 5, 8
            ]
        }
        
        if selection == .evil {
            numbers = [
                0, 5, 0, 0, 3, 8, 0, 0, 2,
                0, 0, 0, 0, 0, 0, 0, 0, 8,
                0, 0, 0, 1, 0, 5, 0, 3, 0,
                0, 0, 0, 0, 4, 6, 0, 0, 0,
                1, 0, 0, 7, 2, 0, 0, 0, 0,
                7, 0, 0, 0, 1, 0, 5, 9, 0,
                5, 0, 1, 0, 0, 0, 6, 0, 0,
                0, 0, 3, 0, 0, 0, 0, 0, 1,
                6, 0, 7, 0, 0, 0, 0, 0, 0
            ]
            
            solution = [
                9, 5, 6, 4, 3, 8, 1, 7, 2,
                3, 1, 4, 2, 6, 7, 9, 5, 8,
                2, 7, 8, 1, 9, 5, 4, 3, 6,
                8, 3, 9, 5, 4, 6, 2, 1, 7,
                1, 4, 5, 7, 2, 9, 8, 6, 3,
                7, 6, 2, 8, 1, 3, 5, 9, 4,
                5, 8, 1, 3, 7, 4, 6, 2, 9,
                4, 9, 3, 6, 5, 2, 7, 8, 1,
                6, 2, 7, 9, 8, 1, 3, 4, 5
            ]
        }
        
        for i in 0...80 {
            if numbers[i] == 0 {
                robotPut[i] = false
            } else {
                robotPut[i] = true
            }
        }
        
    }
    
    
    /*
    I tried to randomly choose numbers for board, and thought that if I randomly choose some elements, there will be at least one solution
    However, when I played I understand it is wrong, but I did not want to delete this code 😅
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
    */
    
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
        if selectedCell != index && robotPut[selectedCell] == false && numbers[selectedCell] != 0 && checkForErrorPuttingNumber(at: selectedCell, number: numbers[selectedCell]) == true {
                return
        }
        
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
        
        if robotPut[selectedCell] == false && numbers[selectedCell] != 0 {
            let _ = checkForErrorPuttingNumber(at: selectedCell, number: numbers[selectedCell])
        }
    }
    
    func userPressedNumber(by number: Int){
        if selectingNumberBlocked == true {
            return
        }
        userPressedCell(by: selectedCell)
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
        
        userPressedCell(by: selectedCell)
        mistakes += checkForErrorPuttingNumber(at: selectedCell, number: number) == true ? 1 : 0
                
    }
    
    private func checkForErrorPuttingNumber(at index: Int, number: Int) -> Bool {
        var have = false
        for i in 0...8 {
            if nineSquares[i].contains(index) == true {
                for j in 0...8 {
                    if numbers[nineSquares[i][j]] == number && nineSquares[i][j] != index {
                        cellColor[nineSquares[i][j]] = .purple
                        have = true
                    }
                }
            }
        }
        for i in ((index / 9) * 9)..<((index / 9 + 1) * 9) {
            if numbers[i] == number && i != index {
                cellColor[i] = .purple
                have = true
            }
        }
        var j = index % 9
        while (j < 81) {
            if numbers[j] == number && j != index {
                cellColor[j] = .purple
                have = true
            }
            j += 9
        }
        return have
    }
    
    func undoButtonPressed() {
        if selectingNumberBlocked == true {
            return
        }
        if let lastElement = lastSteps.last {
            numbers[lastElement.index] = 0
            numberColor[lastElement.index] = .black
            lastSteps.remove(at: lastSteps.count - 1)
            userPressedCell(by: lastElement.index)
        }
    }
    
    func eraseButtonPressed() {
        if selectingNumberBlocked == true {
            return
        }
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
    
    func showSolutionButtonPressed() {
        for i in 0...80 {
            if robotPut[i] == false && numbers[i] != solution[i] {
                numbers[i] = solution[i]
                numberColor[i] = .brown
            }
        }
        userPressedCell(by: selectedCell)
        selectingNumberBlocked = true
        stopTheTimer()
    }
    
    func checkForWinning() -> Bool {
        for index in 0...80 {
            for i in 0...8 {
                if nineSquares[i].contains(index) == true {
                    for j in 0...8 {
                        if numbers[nineSquares[i][j]] == numbers[index] && nineSquares[i][j] != index {
                            return false
                        }
                    }
                }
            }
            for i in ((index / 9) * 9)..<((index / 9 + 1) * 9) {
                if numbers[i] == numbers[index] && i != index {
                    return false
                }
            }
            var j = index % 9
            while (j < 81) {
                if numbers[j] == numbers[index] && j != index {
                    return false
                }
                j += 9
            }
        }
        return true
    }
    
    func addItem(isWin: Bool, context: NSManagedObjectContext) {
        stopTheTimer()
        
        let item = Item(context: context)
        item.isWin = isWin
        item.difficulty = selection.rawValue
        item.date = Date()
        item.time = Int16(time)
        item.mistakes = Int16(mistakes)
        try? context.save()
    }
    
}

