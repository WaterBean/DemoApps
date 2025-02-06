//
//  ShoppingListViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit
import Kingfisher

final class ShoppingListViewController: UIViewController {
    
    let mainView = ShoppingListView()
    let viewModel = ShoppingListViewModel()
    
    // MARK: - ViewController LifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.outputTotalCount.lazyBind { [weak self] text in
            self?.mainView.totalNumberLabel.text = text
        }
        
        viewModel.item.bind { [weak self] _ in
            self?.mainView.collectionView.reloadData()
//            self?.mainView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        }
        
        viewModel.outputFilterButtonTapped.bind { [weak self] option in
            let (option, isNetworkConnected) = option
            self?.buttons.forEach {
                if $0.option == option {
                    $0.isSelected = true
                    print(($0.titleLabel?.text), "선택됨")
                } else {
                    print($0.titleLabel)
                    $0.isSelected = false
                }
            }
            if isNetworkConnected {
                
            } else {
                self?.present(AlertManager.simpleAlert(title: "네트워크 연결 불가", message: "와이파이나 데이터 연결을 확인해주세요."), animated: true)
            }

        }
        viewModel.inputViewDidLoad.value = ()
        
    }
    
    // MARK: - Action
    @objc func filterButtonTapped(_ sender: SortButton) {
        print(#function)
        viewModel.inputFilterButtonTapped.value = sender.option
    }
    
    // MARK: - View Property
    lazy var buttons = [mainView.simButton, mainView.dateButton, mainView.ascButton, mainView.dscButton]
    
}

// MARK: - CollectionView Delegate, DataSource
extension ShoppingListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.item.value.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = viewModel.item.value.items[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell,
              let price = Int(data.lprice)
        else { return ItemCollectionViewCell() }
        cell.configureCell(title: data.title, imageURL: URL(string: data.image), mallName: data.mallName, price: price)
        return cell
    }
    
    
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


extension ShoppingListViewController {
    
    private func setupUI() {
        navigationItem.title = viewModel.query
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        //        mainView.collectionView.prefetchDataSource = self
        
        buttons.forEach {
            $0.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        }
        
    }
    
    
}
