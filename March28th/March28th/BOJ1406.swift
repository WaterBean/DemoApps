//
//  BOJ1406.swift
//  March28th
//
//  Created by 한수빈 on 3/28/25.
//

import Foundation

func boj1406() {
    
    let initialText = readLine()!
    let commandCount = Int(readLine()!)!
    var commands = [String]()
    for _ in 0..<commandCount {
        if let command = readLine() {
            commands.append(command)
        }
    }
    
    print("초기 문자열: \(initialText)")
    print("명령어 개수: \(commands.count)")
    print("명령어 목록:")
    for command in commands {
        print("- \(command)")
    }
    
}

