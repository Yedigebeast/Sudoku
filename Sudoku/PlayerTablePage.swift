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
    
    @State var selectedNumber = 0
    
    let columns = [
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0),
            GridItem(.flexible(), spacing: 0)
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
            sudokuDataModel.time = 0
            sudokuDataModel.activateTheTimer()
        }
        .padding(.horizontal, 5)
    }
    
    var table: some View {
        VStack {
            LazyVGrid(columns: columns, spacing: 0) {
                ForEach(sudokuDataModel.numbers, id: \.self) { number in
                    ZStack {
                        Rectangle()
                            .strokeBorder(Color.black, lineWidth: 1)
                        Text("\(number)")
                    }
                }
            }
            
            Spacer()
            
            HStack {
                Spacer()

                Button {
                    print("Undo button was pressed")
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
                    print("Erase button was pressed")
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
                        selectedNumber = number
                    } label: {
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .frame(width: 35, height: 35)
                                .foregroundColor(.black)
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
