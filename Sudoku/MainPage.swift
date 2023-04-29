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
    
    @Environment(\.managedObjectContext) var managedObjContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .forward)]) var items: FetchedResults<Item>
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
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
                            if sudokuDataModel.lastGameTime != -1 {
                                sudokuDataModel.textForContinueLastGameButton
                            }
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
                        isPlayerTablePage = true
                    }
                    
                    Button(gameDifficulty.medium.rawValue) {
                        sudokuDataModel.selection = gameDifficulty.medium
                        isPlayerTablePage = true
                    }
                    
                    Button(gameDifficulty.hard.rawValue) {
                        sudokuDataModel.selection = gameDifficulty.hard
                        isPlayerTablePage = true
                    }
                    
                    Button(gameDifficulty.expert.rawValue) {
                        sudokuDataModel.selection = gameDifficulty.expert
                        isPlayerTablePage = true
                    }
                    
                    Button(gameDifficulty.evil.rawValue) {
                        sudokuDataModel.selection = gameDifficulty.evil
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
