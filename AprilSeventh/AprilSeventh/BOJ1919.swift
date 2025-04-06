//
//  BOJ1919.swift
//  AprilSeventh
//
//  Created by 한수빈 on 4/7/25.
//

import Foundation

func boj1919() {
  let input1 = readLine()!
  let input2 = readLine()!
  var marking = Array.init(repeating: 0, count: 26)
  input1.forEach { marking[Int($0.asciiValue! - Character(unicodeScalarLiteral: "a").asciiValue!)] += 1 }
  input2.forEach { marking[Int($0.asciiValue! - Character(unicodeScalarLiteral: "a").asciiValue!)] -= 1 }
  marking = marking.map{ abs($0) }
  let result = marking.reduce(0, +)
  print(result)
}
