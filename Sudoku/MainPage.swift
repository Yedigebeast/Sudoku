//
//  MainPage.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import SwiftUI

struct MainPage: View {
    @EnvironmentObject var sudokuDataModel: SudokuModel
    @State private var actionSheet = false
    
    @Binding var isPlayerTablePage: Bool
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Image("icon")
                    .resizable()
                    .frame(width: 200, height: 200)
                
                Spacer()
                    .frame(height: 20)
                
                Text("Sudoku")
                    .font(.custom(Constants.bold, size: 30))
                    .foregroundColor(.black.opacity(0.8))
                
                Spacer()
            }
            
            VStack {
                Spacer()
                
                Button {
                    print("Continue Game button pressed")
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .frame(height: 60)
                            .shadow(color: Constants.shadowColor, radius: 5, x: 0, y: 5)
                        VStack {
                            Text("Continue Game")
                                .font(.custom(Constants.bold, size: 17))
                                .foregroundColor(.white)
                            HStack {
                                Image(systemName: "timer")
                                Text("\(getTimeFromInt(count: 100)) - Easy")
                            }
                            .foregroundColor(.white.opacity(0.4))
                            .font(.custom(Constants.regular, size: 14))
                        }
                    }
                }
                .padding(.horizontal, 64)
                
                Spacer()
                    .frame(height: 10)
                
                Button {
                    actionSheet = true
                } label: {
                    ZStack {
                        RoundedRectangle(cornerRadius: 30)
                            .fill(.white)
                            .frame(height: 60)
                            .shadow(color: Constants.shadowColor, radius: 5, x: 0, y: 5)
                        Text("New Game")
                            .font(.custom(Constants.bold, size: 17))
                            .foregroundColor(.blue)
                    }
                }
                .confirmationDialog("Select a level", isPresented: $actionSheet, titleVisibility: .hidden) {
                    Button(gameDifficulty.easy.rawValue) {
                        sudokuDataModel.selection = gameDifficulty.easy
                        sudokuDataModel.addNumbersToArray()
                        isPlayerTablePage = true
                    }
                    
                    Button(gameDifficulty.medium.rawValue) {
                        sudokuDataModel.selection = gameDifficulty.medium
                        sudokuDataModel.addNumbersToArray()
                        isPlayerTablePage = true
                    }
                    
                    Button(gameDifficulty.hard.rawValue) {
                        sudokuDataModel.selection = gameDifficulty.hard
                        sudokuDataModel.addNumbersToArray()
                        isPlayerTablePage = true
                    }
                    
                    Button(gameDifficulty.expert.rawValue) {
                        sudokuDataModel.selection = gameDifficulty.expert
                        sudokuDataModel.addNumbersToArray()
                        isPlayerTablePage = true
                    }
                    
                    Button(gameDifficulty.evil.rawValue) {
                        sudokuDataModel.selection = gameDifficulty.evil
                        sudokuDataModel.addNumbersToArray()
                        isPlayerTablePage = true
                    }
                }
                .padding(.horizontal, 64)
                
                Spacer()
                    .frame(height: 40)
            }
        }
    }
}

struct MainPage_Previews: PreviewProvider {
    static var previews: some View {
        MainPage(isPlayerTablePage: .constant(false))
    }
}
