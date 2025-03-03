//
//  NetworkManager.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//
import Alamofire
import RxSwift
import Network

final class NetworkManager {

    private init() {}
    static let shared = NetworkManager()
    private let monitor = NWPathMonitor()
    private(set)var status: NWPath.Status?
    
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
    
    func fetchNaverShopping(query: String,
                            sort: String = "sim",
                            start: Int = 1) -> Single<ItemResponse> {
        return Single<ItemResponse>.create { value in
            let endpoint = "https://openapi.naver.com/v1/search/shop.json"
            let parameter: Parameters = ["query": query, "display": 100, "sort": sort, "start": start]
            let (id, secret) = (APIKeyManager.naverClientId, APIKeyManager.naverClientSecret)
            let header: HTTPHeaders = ["X-Naver-Client-Id": id, "X-Naver-Client-Secret": secret]
            
            AF.request(endpoint, method: .get, parameters: parameter, headers: header)
                .validate()
                .responseDecodable(of: ItemResponse.self) { response in
                    switch response.result {
                    case .success(let item):
                        value(.success(item))
                    case .failure(let error):
                        switch error.responseCode {
                        case 400: value(.failure(NetworkError.incorrectQuery))
                        case 401: value(.failure(NetworkError.authenticationFailed))
                        case 403: value(.failure(NetworkError.accessDenied))
                        case 404: value(.failure(NetworkError.invalidSearchAPI))
                        case 405: value(.failure(NetworkError.methodNotAllowed))
                        case 429: value(.failure(NetworkError.quotaExceeded))
                        case 500: value(.failure(NetworkError.systemError))
                        default: value(.failure(NetworkError.unknownError))
                        }
                    }
                }
            return Disposables.create {
                print("Network Request Disposed")
            }
        }
    }
    
    
}
