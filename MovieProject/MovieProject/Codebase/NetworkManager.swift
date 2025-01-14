//
//  NetworkManager.swift
//  MovieProject
//
//  Created by 한수빈 on 1/14/25.
//

import Foundation
import Alamofire

final class NetworkManager {
    static let shared = NetworkManager()
    private init() { }

    private var movieApiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "MOVIE_API_KEY") as? String else {
            fatalError("MOVIE_API_KEY not found in Info.plist")
        }
        return apiKey
    }
    
    func fetchBoxOfficeRanking(date: String, completion: @escaping ([DailyBoxOfficeList]) -> Void) {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "MOVIE_API_KEY") as? String else {
            fatalError("MOVIE_API_KEY not found in Info.plist")
        }
        let endpoint = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
        let parameter: Parameters = ["key" : apiKey, "targetDt" : date]

        AF.request(endpoint, parameters: parameter)
            .responseDecodable(of: BoxOfficeResponse.self) { response in
                switch response.result {
                case .success(let result):
                    completion(result.boxOfficeResult.dailyBoxOfficeList)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
}
