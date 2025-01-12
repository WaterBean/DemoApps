//
//  DateFormatterManager.swift
//  TravelProject
//
//  Created by 한수빈 on 1/6/25.
//

import Foundation

enum DateFormatterManager {
        
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
    
    private static let TravelTalkInputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
    }()
    
    private static let TravelTalkOutputFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yy.MM.dd"
        return formatter
    }()
    
    static func formatMagazineDate(_ dateString: String) -> String? {
        guard let date = magazineInputFormatter.date(from: dateString) else {
            return nil
        }
        return magazineOutputFormatter.string(from: date)
    }
    
    static func formatTravleTalkDate(_ dateString: String) -> String? {
        guard let date = TravelTalkInputFormatter.date(from: dateString) else {
            return nil
        }
        return TravelTalkOutputFormatter.string(from: date)
    }
    
    
}
