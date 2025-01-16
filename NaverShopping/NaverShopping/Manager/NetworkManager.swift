//
//  NetworkManager.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    

    
    func fetchNaverShopping(query: String, sort: String = "sim", start: Int = 1, completion: @escaping (ItemResponse?) -> Void) {
        let endpoint = "https://openapi.naver.com/v1/search/shop.json"
        let parameter: Parameters = ["query": query, "display": 30, "sort": sort, "start": start]
        let (id, secret) = (APIKeyManager.naverClientId, APIKeyManager.naverClientSecret)
        let header: HTTPHeaders = ["X-Naver-Client-Id": id, "X-Naver-Client-Secret": secret]
        print(parameter)
        AF.request(endpoint, method: .get, parameters: parameter, headers: header)
            .validate()
            .responseDecodable(of: ItemResponse.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    completion(nil)
                    print(error)
                    
                }
            }
    }
}
