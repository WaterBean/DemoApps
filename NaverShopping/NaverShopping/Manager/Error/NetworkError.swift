//
//  NetworkError.swift
//  NaverShopping
//
//  Created by 한수빈 on 2/26/25.
//

import Foundation

enum NetworkError: Error {
    
    case incorrectQuery
    case invalidDisplayValue
    case invalidStartValue
    case invalidSortValue
    case malformedEncoding
    case invalidSearchAPI
    case systemError
    
    case authenticationFailed
    case accessDenied
    case methodNotAllowed
    case quotaExceeded
    
    case networkDisconnected
    case unknownError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .incorrectQuery:
            return "잘못된 쿼리 요청"
        case .invalidDisplayValue:
            return "부적절한 display 값"
        case .invalidStartValue:
            return "부적절한 start 값"
        case .invalidSortValue:
            return "부적절한 sort 값"
        case .malformedEncoding:
            return "잘못된 형식의 인코딩"
        case .invalidSearchAPI:
            return "존재하지 않는 검색 API"
        case .systemError:
            return "시스템 에러"
        case .authenticationFailed:
            return "인증 실패"
        case .accessDenied:
            return "접근 거부됨"
        case .methodNotAllowed:
            return "허용되지 않는 메서드"
        case .quotaExceeded:
            return "호출 한도 초과"
        case .networkDisconnected:
            return "네트워크 연결 불가"
        case .unknownError:
            return "알 수 없는 오류"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .incorrectQuery:
            return "API 요청 URL의 프로토콜, 파라미터 등에 오류가 있습니다."
        case .invalidDisplayValue:
            return "display 파라미터의 값이 허용 범위(1~100)를 벗어났습니다."
        case .invalidStartValue:
            return "start 파라미터의 값이 허용 범위(1~1000)를 벗어났습니다."
        case .invalidSortValue:
            return "sort 파라미터의 값에 오타가 있거나 잘못된 값입니다."
        case .malformedEncoding:
            return "검색어를 UTF-8로 인코딩해야 합니다."
        case .invalidSearchAPI:
            return "API 요청 URL에 오타가 있습니다."
        case .systemError:
            return "서버 내부에 오류가 발생했습니다."
        case .authenticationFailed:
            return "클라이언트 ID와 시크릿이 없거나 잘못되었습니다."
        case .accessDenied:
            return "HTTPS 사용이 필요하거나 접근 권한이 없습니다."
        case .methodNotAllowed:
            return "올바른 HTTP 메서드를 사용하세요."
        case .quotaExceeded:
            return "일일 호출 한도 또는 초당 호출 한도를 초과했습니다."
        case .networkDisconnected:
            return "와이파이나 데이터 연결을 확인해보세요."
        case .unknownError:
            return "알 수 없는 문제가 발생했습니다."
        }
    }
    
}
