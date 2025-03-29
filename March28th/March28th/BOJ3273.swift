//
//  BOJ3273.swift
//  March28th
//
//  Created by 한수빈 on 3/28/25.
//

import Foundation

func boj3273() {
    let n = Int(readLine()!)!
    let arr = readLine()!.split(separator: " ").map { Int($0)! }
    let x = Int(readLine()!)!
    var answer = 0
    var vis: [Bool] = .init(repeating: false, count: 2_000_000 + 2)
    for element in arr {
      vis[element] = true
    }
    for element in arr {
      if element < x && vis[x - element] { answer += 1 }
    }

    print(answer / 2)

}
