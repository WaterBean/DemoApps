//
//  ShoppingMainViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit

final class ShoppingMainViewController: UIViewController {
    let mainView = ShoppingMainView()
    
    // MARK: - ViewController LifeCycle
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.startMonitoring()
        navigationItem.title = "도봉러의 쇼핑쇼핑"
        mainView.searchBar.delegate = self

    }

    
    // MARK: - Action
    
    
    func searchItem(text: String) {
        NetworkManager.shared.fetchNaverShopping(query: text, start: 1) { response in
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


// MARK: - SearchBar Delegate


extension ShoppingMainViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        guard NetworkManager.shared.isFetching == false else { print("요청중임"); return }
        if NetworkManager.shared.status == .satisfied {
            guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines), text.count >= 2 else {
                present(AlertManager.simpleAlert(title: "2자 이상 입력", message: "두글자 이상 입력해주세요."), animated: true)
                searchBar.text = ""
                return
            }
            searchItem(text: text)
        } else {
            present(AlertManager.networkNotConnectionAlert(handler: { _ in
                URLSchemeManager.shared.openSystemSetting()
            }), animated: true)
        }
        searchBar.isEnabled = false
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1) {
            searchBar.isEnabled = true
            print(searchBar.isEnabled)
        }
    }
    
}



