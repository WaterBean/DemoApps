//
//  ShoppingListViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit
import Kingfisher

final class ShoppingListViewController: UIViewController {
    
    lazy var enableStartRange = 1...(item?.total ?? 0)
    var query: String = ""
    var item: ItemResponse? {
        didSet {
            mainView.collectionView.reloadData()
        }
    }

    let mainView = ShoppingListView()
    
    // MARK: - ViewController LifeCycle
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = query
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.prefetchDataSource = self
        
        NetworkManager.shared.fetchNaverShopping(query: query, start: 1) { response in
            switch response {
            case .success(let success):
                self.item = success
            case .failure(let failure):
                print(failure)
            }
        }
        
        buttons.forEach {
            $0.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        }
        
        guard let total = item?.total.formatted(.number) else { return }
        mainView.totalNumberLabel.text = "\(total) 개의 검색 결과"
        
    }
    
    // MARK: - Action
    @objc func filterButtonTapped(_ sender: SortButton) {
        buttons.forEach {
            $0.isSelected = false
        }
        sender.isSelected = true
        selectedOption = sender.option
        
        if self.item?.total == 0 { print("0임"); return }
        
        mainView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: false)
        if NetworkManager.shared.status == .satisfied {
            NetworkManager.shared.fetchNaverShopping(query: navigationItem.title ?? "", sort: selectedOption.fetchString, start: 1) { result in
                switch result {
                case .success(let success):
                    self.item = success
                case .failure(let failure):
                    print(failure)
                }
            }
        } else {
            present(AlertManager.simpleAlert(title: "네트워크 연결 불가", message: "와이파이나 데이터 연결을 확인해주세요."), animated: true)
        }
        
    }
    
    // MARK: - View Property
    lazy var buttons = [mainView.simButton, mainView.dateButton, mainView.ascButton, mainView.dscButton]
    var selectedOption: SortButton.SortOption = .sim

}

// MARK: - CollectionView Delegate, DataSource
extension ShoppingListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        item?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = item?.items[indexPath.item],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell,
              let price = Int(item.lprice)
        else { return ItemCollectionViewCell() }
        
        cell.configureCell(title: item.title, imageURL: URL(string: item.image), mallName: item.mallName, price: price)
        return cell
    }
    
    
}


// MARK: - Prefetching(Pagination)
extension ShoppingListViewController: UICollectionViewDataSourcePrefetching {
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //        print(#function, indexPaths, self.item?.items.count, self.item?.start)
        guard let item,
              let text = navigationItem.title else { return }
        guard enableStartRange ~= item.start else {
            print("현재가 마지막 페이지임")
            return
        }
        print(indexPaths[0].item, item.items.count - 8)
        if NetworkManager.shared.status == .satisfied {
            if indexPaths[0].item >= item.items.count - 8 {
                self.item?.start += 30
                NetworkManager.shared.fetchNaverShopping(query: text, sort: selectedOption.fetchString, start: item.start + 30) { result in
                    switch result {
                    case .success(let success):
                        self.item?.items.append(contentsOf: success.items)
                        self.item?.start = success.start
                    case .failure(let failure):
                        print(#function)
                    }
                }
            }
        } else {
            present(AlertManager.simpleAlert(title: "네트워크 연결 불가", message: "와이파이나 데이터 연결을 확인해주세요."), animated: true)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            guard let cell = collectionView.cellForItem(at: indexPath) as? ItemCollectionViewCell else { return }
            cell.itemImage.kf.cancelDownloadTask() // 이게 되는지 어떻게 확인?
        }
        print(#function)
    }
    
    
}
