//
//  BOJ1158.swift
//  March28th
//
//  Created by 한수빈 on 3/28/25.
//

import Foundation

func boj1158() {
    var list: LinkedList<Int> = LinkedList()
    let input = readLine()!.split(separator: " ").map { Int($0)! }
    let n = input[0]
    let k = input[1]
    
    for i in 1...n {
        list.append(i)
    }
    var result = [Int]()
    var target = 0
    
    while !list.isEmpty {
        target = (target + k - 1) % list.count
        if let removed = list.remove(at: target) {
            result.append(removed)
        }
    }
    
    let output = result.map { String($0) }.joined(separator: ", ")
    print("<\(output)>")

}
