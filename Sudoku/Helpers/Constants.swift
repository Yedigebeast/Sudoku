//
//  Constants.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import Foundation
import SwiftUI

struct Constants {
    static var regular = "Montserrat-Regular"
    static var semibold = "Montserrat-Semibold"
    static var bold = "Montserrat-Bold"
    
    static var primaryColor = Color.cyan.opacity(0.05)
    static var shadowColor = Color.cyan.opacity(0.5)
}

enum gameDifficulty: String {
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"
    case expert = "Expert"
    case evil = "Evil"
    case none = "None"
}
