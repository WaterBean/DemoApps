//
//  ShoppingListViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit

final class ShoppingListViewController: UIViewController {
    let mainView = ShoppingListView()
    
    var item: ItemResponse? {
        didSet {
            mainView.collectionView.reloadData()
        }
    }
    lazy var buttons = [mainView.simButton, mainView.dateButton, mainView.ascButton, mainView.dscButton]

    // MARK: - ViewController LifeCycle
    
    
    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self

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
        
        NetworkManager.shared.fetchNaverShopping(query: navigationItem.title ?? "", sort: sender.option.fetchString) {
            self.item = $0
        }
        
    }
    
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
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cancelPrefetchingForItemsAt indexPaths: [IndexPath]) {
        
    }
}
