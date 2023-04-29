//
//  DataController.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import SwiftUI
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load the data \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("We could not save the data...")
        }
    }
        
    func addItem(isStarted: Bool, isFinished: Bool, isWin: Bool, difficulty: String, date: Date, time: Int, mistakes: Int, context: NSManagedObjectContext) {
        let item = Item(context: context)
        item.isStarted = isStarted
        item.isFinished = isStarted
        item.isWin = isWin
        item.difficulty = difficulty
        item.date = date
        item.time = Int16(time)
        item.mistakes = Int16(mistakes)
        save(context: context)
    }
    
}

