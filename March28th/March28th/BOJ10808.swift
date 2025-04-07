//
//  BOJ10808.swift
//  March28th
//
//  Created by 한수빈 on 3/28/25.
//

import Foundation

func boj10808() {
    let input = readLine()!
    var mark: [Int] = Array(repeating: 0, count: 26)
    _ = input.map {
        mark[Int($0.asciiValue! - 97)] += 1
    }
    
    for count in mark {
        print(count, terminator: " ")
    }

}

