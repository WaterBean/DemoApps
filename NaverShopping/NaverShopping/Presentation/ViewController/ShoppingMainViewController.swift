//
//  ShoppingMainViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit
import SnapKit

final class ShoppingMainViewController: UIViewController {

    let mainView = ShoppingMainView()
    
    // MARK: - ViewController LifeCycle
    override func loadView() {
        view = mainView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도봉러의 쇼핑쇼핑"
        mainView.searchBar.delegate = self

    }

    
    // MARK: - Custom Function
    func searchItem(text: String) {
        NetworkManager.shared.fetchNaverShopping(query: text) { response in
            guard let response else { self.mainView.label.text = "다른 검색어를 입력해보세요."; return }
            
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



