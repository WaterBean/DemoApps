//
//  ShoppingListViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit
import Kingfisher
import RxCocoa
import RxSwift

final class ShoppingListViewController: UIViewController {
    
    private let mainView = ShoppingListView()
    private let viewModel: ShoppingListViewModel
    private let disposeBag = DisposeBag()

    init(viewModel: ShoppingListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = mainView
    }
    
    private func bind() {
        let simButtonTapped = mainView.simButton.rx.tap
            .withUnretained(self)
            .map { owner, _ in owner.mainView.simButton.option }
        
        let dateButtonTapped = mainView.dateButton.rx.tap
            .withUnretained(self)
            .map { owner, _ in owner.mainView.dateButton.option }
        
        let dscButtonTapped = mainView.dscButton.rx.tap
            .withUnretained(self)
            .map { owner, _ in owner.mainView.dscButton.option }
        
        let ascButtonTapped = mainView.ascButton.rx.tap
            .withUnretained(self)
            .map { owner, _ in owner.mainView.ascButton.option }
        
        let itemTapped = mainView.collectionView.rx.itemSelected
        
        let input = ShoppingListViewModel.Input(
            simButtonTapped: simButtonTapped,
            dateButtonTapped: dateButtonTapped,
            dscButtonTapped: dscButtonTapped,
            ascButtonTapped: ascButtonTapped,
            itemTapped: itemTapped
        )
        
        let output = viewModel.transform(input: input)
        
        output.query
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
        
        output.searchList
            .bind(to: mainView.collectionView.rx.items(
                cellIdentifier: "ItemCollectionViewCell",
                cellType: ItemCollectionViewCell.self)) { item, element, cell in
                    cell.configureCell(item: element)
                }
                .disposed(by: disposeBag)
        
        
        output.searchListTotal
            .bind(to: mainView.totalNumberLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.buttonStatus
            .bind(with: self) { owner, option in
                owner.buttons.forEach { button in
                    button.isSelected = false
                }
                switch option {
                case .sim:
                    owner.mainView.simButton.rx.isSelected.onNext(true)
                case .date:
                    owner.mainView.dateButton.rx.isSelected.onNext(true)
                case .dsc:
                    owner.mainView.dscButton.rx.isSelected.onNext(true)
                case .asc:
                    owner.mainView.ascButton.rx.isSelected.onNext(true)
                }
            }
            .disposed(by: disposeBag)
        
        output.someError
            .bind(with: self) { owner, error in
                switch error {
                case .networkDisconnected:
                    owner.present( AlertManager.networkNotConnectionAlert { _ in
                        URLSchemeManager.shared.openSystemSetting()
                    }, animated: true)
                default:
                    owner.present(
                        AlertManager.simpleAlert(
                            title: error.localizedDescription,
                            message: error.failureReason ?? ""),
                        animated: true)
                }
            }
            .disposed(by: disposeBag)
        
        output.toItemDetail
            .bind(with: self) { owner, value in
                owner.navigationController?.pushViewController(DetailItemViewController(url: value), animated: true)
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    lazy var buttons = [mainView.simButton, mainView.dateButton, mainView.ascButton, mainView.dscButton]
    
    
}

// MARK: - Prefetching(Pagination)
//extension ShoppingListViewController: UICollectionViewDataSourcePrefetching {
//
//    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
//        //        print(#function, indexPaths, self.item?.items.count, self.item?.start)
//        guard let item,
//              let text = navigationItem.title else { return }
//        guard enableStartRange ~= item.start else {
//            print("현재가 마지막 페이지임")
//            return
//        }
//        print(indexPaths[0].item, item.items.count - 8)
//        if NetworkManager.shared.status == .satisfied {
//            if indexPaths[0].item >= item.items.count - 8 {
//                self.item?.start += 30
//                NetworkManager.shared.fetchNaverShopping(query: text, sort: selectedOption.fetchString, start: item.start + 30) { result in
//                    switch result {
//                    case .success(let success):
//                        self.item?.items.append(contentsOf: success.items)
//                        self.item?.start = success.start
//                    case .failure(let failure):
//                        print(#function)
//                    }
//                }
//            }
//        } else {
//            present(AlertManager.simpleAlert(title: "네트워크 연결 불가", message: "와이파이나 데이터 연결을 확인해주세요."), animated: true)
//        }
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
//        indexPaths.forEach { indexPath in
//            guard let cell = collectionView.cellForItem(at: indexPath) as? ItemCollectionViewCell else { return }
//            cell.itemImage.kf.cancelDownloadTask() // 이게 되는지 어떻게 확인?
//        }
//        print(#function)
//    }
//
//
//}

