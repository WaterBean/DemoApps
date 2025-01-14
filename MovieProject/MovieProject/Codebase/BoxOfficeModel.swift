//
//  BoxOfficeModel.swift
//  MovieProject
//
//  Created by 한수빈 on 1/14/25.
//

import Foundation

struct BoxOfficeResponse: Codable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let openDt: String
}

enum CustomError: Error {
    case decoding
}
