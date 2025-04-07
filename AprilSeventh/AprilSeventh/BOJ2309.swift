//
//  BOJ2309.swift
//  AprilSeventh
//
//  Created by 한수빈 on 4/7/25.
//

import Foundation

func boj2309() {
  var a = Array(repeating: 0, count: 9)
  var r = Array(repeating: 0, count: 9)
  for i in 0...8 {
    a[i] = Int(readLine()!)!
  }
  while true { // 좋은 코드는 아닌것 같지만...
    r = a.shuffled()
    r.removeLast()
    r.removeLast()
    if r.reduce(0, +) == 100 {
      break
    }
  }
  r.sort(by: <)
  for p in r {
    print(p)
  }
}
