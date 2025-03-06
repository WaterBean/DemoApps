//
//  ShoppingMainViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit
import RxCocoa
import RxSwift

final class ShoppingMainViewController: UIViewController {
    
    private let mainView = ShoppingMainView()
    private let likeListButton = UIBarButtonItem(image: UIImage(systemName: "heart"), style: .plain, target: nil, action: nil)
    private let wishListButton = UIBarButtonItem(image: UIImage(systemName: "star"), style: .plain, target: nil, action: nil)
    private let viewModel = ShoppingMainViewModel()
    private let disposeBag = DisposeBag()

    private func bind() {
        let searchButtonClicked = mainView.searchBar.rx.searchButtonClicked
        let searchText = mainView.searchBar.rx.text.orEmpty
        let likeListButtonTap = likeListButton.rx.tap
        let wishListButtonTap = wishListButton.rx.tap
        
        let input = ShoppingMainViewModel.Input(
            likeListButtonTap: likeListButtonTap,
            wishListButtonTap: wishListButtonTap,
            searchButtonClicked: searchButtonClicked,
            searchText: searchText
        )
        let output = viewModel.transform(input: input)
        
        output.searchResult
            .bind(with: self) { owner, result in
                switch result {
                case .success(let query):
                    let vc = ShoppingListViewController(
                        viewModel: ShoppingListViewModel(query: query)
                    )
                    let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
                    backBarButtonItem.tintColor = .white
                    owner.navigationItem.backBarButtonItem = backBarButtonItem
                    owner.navigationController?.pushViewController(vc, animated: true)
                case .failure(let error):
                    switch error {
                    case .networkDisconnected:
                        owner.present(AlertManager.networkNotConnectionAlert(handler: { _ in
                            URLSchemeManager.shared.openSystemSetting()
                        }), animated: true)
                    case .minimumQueryLengthLimited:
                        owner.present(AlertManager.simpleAlert(title: error.localizedDescription, message: error.errorDescription!), animated: true)
                    }
                }
            }
            .disposed(by: disposeBag)
        
        output.wishList
            .drive(with: self){ owner, _ in
                let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: owner, action: nil)
                backBarButtonItem.tintColor = .white
                owner.navigationItem.backBarButtonItem = backBarButtonItem
                owner.navigationController?.pushViewController(FolderListViewController(), animated: true)
            }
            .disposed(by: disposeBag)
            
        output.likeList
            .drive(with: self) { owner, _ in
                let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: owner, action: nil)
                backBarButtonItem.tintColor = .white
                owner.navigationItem.backBarButtonItem = backBarButtonItem

                owner.navigationController?.pushViewController(LikeListViewController(), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func loadView() {
        view = mainView
        bind()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.startMonitoring()
        configureUI()
        
    }
    
    
}


// MARK: - Configure UI
extension ShoppingMainViewController {
    
    private func configureUI() {
        navigationItem.title = "도봉러의 쇼핑쇼핑"
        navigationItem.setRightBarButtonItems([wishListButton, likeListButton], animated: true)
    }
    
    
}
