//
//  ShoppingMainViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit
import Alamofire
import SnapKit

final class ShoppingMainViewController: UIViewController {

    private let searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.barStyle = .black
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private let backgroundImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background-image")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label = {
        let label = UILabel()
        label.text = "쇼핑 하구팡"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierarchy()
        configureLayout()
        configureView()
    }

    
    // MARK: - Custom Function
    func searchItem(text: String) {
        NetworkManager.shared.fetchNaverShopping(query: text) { response in
            guard let response else { self.label.text = "다른 검색어를 입력해보세요."; return }
            
            let vc = ShoppingListViewController()
            vc.list = response
            let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = .black
            self.navigationItem.backBarButtonItem = backBarButtonItem
            vc.navigationItem.title = text
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension ShoppingMainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text, text.count >= 2 else { return }
        searchItem(text: text)
    }
}

extension ShoppingMainViewController: Presentable {
    func configureHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(backgroundImageView)
        view.addSubview(label)
    }
    
    func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(200)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(backgroundImageView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        navigationItem.title = "도봉러의 쇼핑쇼핑"

        searchBar.delegate = self
    }
    
    
}


final class NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    
    func fetchNaverShopping(query: String, completion: @escaping (ItemResponse?) -> Void) {
        let endpoint = "https://openapi.naver.com/v1/search/shop.json"
        let parameter: Parameters = ["query": query]
        let (id, secret) = (APIKeyManager.naverClientId, APIKeyManager.naverClientSecret)
        let header: HTTPHeaders = ["X-Naver-Client-Id": id, "X-Naver-Client-Secret": secret]
    
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


struct ItemResponse: Decodable {
    let total: Int
    let start: Int
    var items: [Item]
}


struct Item: Decodable {
    let title: String
    let image: String
    let mallName: String
    let lprice: String
}
