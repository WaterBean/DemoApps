//
//  APIKeyManager.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import Foundation

struct APIKeyManager {
    static let naverClientId = Bundle.main.object(forInfoDictionaryKey: "NAVER_CLIENT_ID") as! String
    static let naverClientSecret = Bundle.main.object(forInfoDictionaryKey: "NAVER_CLIENT_SECRET") as! String 
}
