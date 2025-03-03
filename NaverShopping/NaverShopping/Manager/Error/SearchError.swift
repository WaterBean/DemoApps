//
//  SearchError.swift
//  NaverShopping
//
//  Created by 한수빈 on 2/26/25.
//

import Foundation

enum SearchError: Error {
    case networkDisconnected
    case minimumQueryLengthLimited
}

extension SearchError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .networkDisconnected:
            "네트워크 연결 불가"
        case .minimumQueryLengthLimited:
            "2자 이상 입력"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .networkDisconnected:
            "와이파이나 데이터 연결을 확인해보세요."
        case .minimumQueryLengthLimited:
            "두글자 이상 입력해주세요"
        }
    }
    
    
}
