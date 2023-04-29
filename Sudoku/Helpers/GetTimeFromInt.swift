//
//  GetTimeFromInt.swift
//  Sudoku
//
//  Created by Yedige Ashirbek on 29.04.2023.
//

import Foundation

func getTimeFromInt(count: Int) -> String {
    var ans = ""
    ans += addZero(x: "\(count / 60)")
    ans += ":"
    ans += addZero(x: "\(count % 60)")
    return ans
}

private func addZero(x: String) -> String {
    var ans = ""
    if (x.count == 1){
        ans = "0\(x)"
    } else {
        ans = x
    }
    return ans
}
