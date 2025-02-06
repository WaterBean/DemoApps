//
//  ShoppingMainViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit

final class ShoppingMainViewController: UIViewController {
    
    let mainView = ShoppingMainView()
    let viewModel = ShoppingMainViewModel()

    // MARK: - ViewController LifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.startMonitoring()
        configureUI()
        viewModel.outputSearch.lazyBind { [weak self] data in
            guard data.isNetworkConnected else {
                self?.present(AlertManager.networkNotConnectionAlert(handler: { _ in
                    URLSchemeManager.shared.openSystemSetting()
                }), animated: true)
                return
            }
            
            guard let query = data.query else {
                self?.present(AlertManager.simpleAlert(title: "2자 이상 입력", message: "두글자 이상 입력해주세요."), animated: true)
                self?.mainView.searchBar.text = ""
                return
            }
            
            let vc = ShoppingListViewController()
            vc.viewModel.query = query
            let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
            backBarButtonItem.tintColor = .white
            self?.navigationItem.backBarButtonItem = backBarButtonItem
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
}


// MARK: - SearchBar Delegate
extension ShoppingMainViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.inputSearchButtonTapped.value = searchBar.text
    }
    
    
}


// MARK: - Configure UI
extension ShoppingMainViewController {
    
    private func configureUI() {
        navigationItem.title = "도봉러의 쇼핑쇼핑"
        mainView.searchBar.delegate = self
    }
    
    
}
