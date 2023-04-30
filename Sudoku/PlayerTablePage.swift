//
//  PlayerTablePage.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import SwiftUI

struct PlayerTablePage: View {
    @EnvironmentObject var sudokuDataModel: SudokuModel
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .forward)]) var items: FetchedResults<Item>
    
    @Binding var isPlayerTablePage: Bool
    
    @State private var isLosted = false
    @State private var showSolution = false
    @State private var isWin = false
        
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
            
            Button {
                showSolution = true
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(.blue)
                        .frame(height: 60)
                        .shadow(color: Constants.shadowColor, radius: 5, x: 0, y: 5)
                    Text("Show Solution")
                        .font(.custom(Constants.bold, size: 17))
                        .foregroundColor(.white)
                }
            }
            .padding(.horizontal, 64)
            
            Spacer()
            
        }
        .onChange(of: sudokuDataModel.mistakes, perform: { newValue in
            if newValue == 3 {
                isLosted = true
            }
        })
        .onChange(of: sudokuDataModel.numbers, perform: { newValue in
            if newValue.contains(0) == false {
                isWin = sudokuDataModel.checkForWinning()
            }
        })
        .alert("Game is Ended", isPresented: $isLosted) {
            Button("You lost Bro 🥲", role: .cancel) {
                sudokuDataModel.addItem(isWin: isWin, context: managedObjContext)
                isPlayerTablePage = false
            }
        }
        .alert("Game is Ended", isPresented: $isWin) {
            Button("You Winned Bro 🎉", role: .cancel) {
                sudokuDataModel.addItem(isWin: isWin, context: managedObjContext)
                isPlayerTablePage = false
            }
        }
        .alert("Are you sure, You want to see solution", isPresented: $showSolution) {
            Button("I'm sure", role: .destructive) {
                sudokuDataModel.showSolutionButtonPressed()
            }
            Button("Cancel", role: .cancel) {}
        }
        .onAppear{
            sudokuDataModel.stopTheTimer()
            sudokuDataModel.activateTheTimer()
        }
        .onDisappear{
            sudokuDataModel.reset()
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
