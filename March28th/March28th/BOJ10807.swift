//
//  BOJ10807.swift
//  March28th
//
//  Created by 한수빈 on 3/28/25.
//

import Foundation

func boj10807() {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    let x = Int(readLine()!)!
    var answer = 0
    for element in arr {
        if element == x {
            answer += 1
        }
    }
    print(answer)

}

