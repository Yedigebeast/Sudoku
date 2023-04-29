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
            
            Spacer()
                .frame(height: 10)
        }
        .onAppear{
            sudokuDataModel.stopTheTimer()
            sudokuDataModel.time = 0
            sudokuDataModel.activateTheTimer()
        }
        .padding(.horizontal, 5)
    }
}

struct PlayerTablePage_Previews: PreviewProvider {
    static var previews: some View {
        PlayerTablePage(isPlayerTablePage: .constant(true))
    }
}
