//
//  ShoppingMainViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit
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
            vc.item = response
            let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = .white
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

