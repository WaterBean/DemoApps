//
//  String+Extension.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/16/25.
//


extension String {
    var htmlEscaped: String {
        return self
            .replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression)
            .replacingOccurrences(of: "&quot;", with: "\"")
            .replacingOccurrences(of: "&nbsp;", with: "", options: .regularExpression)

    }
    
}
