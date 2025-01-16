//
//  String+Extension.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/16/25.
//


extension String {
    var htmlEscaped: String {
        return self.replacingOccurrences(of: "<[^>]+>&quot;", with: "", options: .regularExpression)
    }
    
}
