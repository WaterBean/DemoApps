//
//  LotteryModel.swift
//  MovieProject
//
//  Created by 한수빈 on 1/14/25.
//

import Foundation

struct LotteryModel: Codable {
    let drwNoDate: String
    let drwtNo1, drwtNo2, drwtNo3, drwtNo4, drwtNo5, drwtNo6: Int
    let bnusNo, drwNo: Int
}

