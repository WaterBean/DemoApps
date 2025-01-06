//
//  DateFormatterManager.swift
//  TravelProject
//
//  Created by 한수빈 on 1/6/25.
//

import Foundation

public struct DateFormatterManager {
    private static let magazineInputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyMMdd"
        return formatter
    }()
    
    private static let magazineOutputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy년 MM월 dd일"
        return formatter
    }()
    
    static func formatMagazineDate(_ dateString: String) -> String? {
        guard let date = magazineInputFormatter.date(from: dateString) else {
            return nil
        }
        return magazineOutputFormatter.string(from: date)
    }
}
