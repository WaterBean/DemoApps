//
//  NetworkManager.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//
import Alamofire
import Network

final class NetworkManager {
    static let shared = NetworkManager()
    private let monitor = NWPathMonitor()
    private(set)var status: NWPath.Status?
    private init() {}
    
    func startMonitoring() {
        monitor.start(queue: .global())
        print("모니터링 시작")
        
        monitor.pathUpdateHandler = { path in
            print(path.status)
            if path.status == .satisfied {
                // 인터넷 연결 O
                print("연결됨")
                self.status = .satisfied
            } else {
                print("연결실패")
                self.status = .unsatisfied
            }
        }
    }
    
    func fetchNaverShopping(query: String, sort: String = "sim", start: Int = 1, completion: @escaping (Result<ItemResponse, AFError>) -> Void) {
        let endpoint = "https://openapi.naver.com/v1/search/shop.json"
        let parameter: Parameters = ["query": query, "display": 100, "sort": sort, "start": start]
        let (id, secret) = (APIKeyManager.naverClientId, APIKeyManager.naverClientSecret)
        let header: HTTPHeaders = ["X-Naver-Client-Id": id, "X-Naver-Client-Secret": secret]
        print(parameter)
        AF.request(endpoint, method: .get, parameters: parameter, headers: header)
            .validate()
            .responseDecodable(of: ItemResponse.self) { response in
                completion(response.result)
            }
    }
    
    
}
