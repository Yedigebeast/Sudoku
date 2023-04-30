//
//  PlayerTablePage.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import SwiftUI

struct PlayerTablePage: View {
    @EnvironmentObject var sudokuDataModel: SudokuModel
    
    @Binding var isPlayerTablePage: Bool
        
    private let columns = [
            GridItem(.fixed(40), spacing: 0),
            GridItem(.fixed(40), spacing: 0),
            GridItem(.fixed(40), spacing: 0),
            GridItem(.fixed(40), spacing: 0),
            GridItem(.fixed(40), spacing: 0),
            GridItem(.fixed(40), spacing: 0),
            GridItem(.fixed(40), spacing: 0),
            GridItem(.fixed(40), spacing: 0),
            GridItem(.fixed(40), spacing: 0),
    ]
    
    private let columns1 = [
        GridItem(.fixed(120), spacing: 0),
        GridItem(.fixed(120), spacing: 0),
        GridItem(.fixed(120), spacing: 0),
    ]
    
    var body: some View {
        VStack {
            ZStack {
                HStack {
                    Button {
                        isPlayerTablePage = false
                    } label: {
                        Image(systemName: "chevron.left")
                    }
                    Spacer()
                }
                HStack {
                    Spacer()
                    Text("Sudoku")
                    Spacer()
                }
            }.font(.custom(Constants.bold, size: 22))
                        
            Spacer()
                .frame(height: 32)
            
            HStack {
                Text(sudokuDataModel.selection.rawValue)
                
                Spacer()
                
                Text("Mistakes: \(sudokuDataModel.mistakes)/3")
                
                Spacer()
                
                Text(getTimeFromInt(count: sudokuDataModel.time))
                    .onReceive(sudokuDataModel.timer, perform: { input in
                        sudokuDataModel.time += 1
                    })
            }
            .font(.custom(Constants.regular, size: 12))
            .padding(.bottom, 10)
            
            table
            
        }
        .onAppear{
            sudokuDataModel.stopTheTimer()
            sudokuDataModel.activateTheTimer()
        }
        .onDisappear{
            sudokuDataModel.lastSteps = []
            sudokuDataModel.numbers = Array.init(repeating: 0, count: 81)
            sudokuDataModel.robotPut = Array.init(repeating: false, count: 81)
            sudokuDataModel.cellColor = Array.init(repeating: Color.white, count: 81)
            sudokuDataModel.numberColor = Array.init(repeating: Color.black, count: 81)
        }
        .padding(.horizontal, 5)
    }
    
    var table: some View {
        VStack {
            ZStack {
                LazyVGrid(columns: columns, spacing: 0) {
                    ForEach((0...80), id: \.self) {id in
                        Button {
                            sudokuDataModel.userPressedCell(by: id)
                        } label: {
                            ZStack {
                                Rectangle()
                                    .fill(sudokuDataModel.cellColor[id])
                                Rectangle()
                                    .strokeBorder(Color.gray, lineWidth: 1)
                                Text(sudokuDataModel.numbers[id] != 0 ? "\(sudokuDataModel.numbers[id])" : "")
                                    .font(.system(size: 24))
                                    .foregroundColor(sudokuDataModel.numberColor[id])
                            }
                            .frame(width: 40, height: 40)
                        }
                    }
                }
                
                LazyVGrid(columns: columns1, spacing: 0) {
                    ForEach((1...9), id: \.self) {id in
                        Rectangle()
                            .strokeBorder(Color.black, lineWidth: 1.5)
                            .frame(width: 120, height: 120)
                    }
                }
                
                Rectangle()
                    .strokeBorder(Color.black, lineWidth: 3)
                    .frame(width: 360, height: 360)
            }
            
            Spacer()
            
            HStack {
                Spacer()

                Button {
                    sudokuDataModel.undoButtonPressed()
                } label: {
                    VStack {
                        Image(systemName: "arrow.uturn.backward.circle")
                            .font(.system(size: 20))
                        Text("Undo")
                            .font(.custom(Constants.regular, size: 20))
                    }
                }
                
                Spacer()
                
                Button {
                    sudokuDataModel.eraseButtonPressed()
                } label: {
                    VStack {
                        Image(systemName: "eraser.line.dashed")
                            .font(.system(size: 20))
                        Text("Erase")
                            .font(.custom(Constants.regular, size: 20))
                    }
                }
                
                Spacer()
            }
            .foregroundColor(.black)
            
            Spacer()
            
            HStack {
                Spacer()
                ForEach((1...9), id: \.self) {number in
                    Button {
                        sudokuDataModel.userPressedNumber(by: number)
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 35, height: 35)
                                .foregroundColor(sudokuDataModel.selectedNumber == number ? .blue : .black)
                            Text("\(number)")
                                .font(.custom(Constants.regular, size: 30))
                                .foregroundColor(.white)
                        }
                    }
                    Spacer()
                }
            }
            Spacer()
        }
    }
}

struct PlayerTablePage_Previews: PreviewProvider {
    static var previews: some View {
        PlayerTablePage(isPlayerTablePage: .constant(true))
    }
}
