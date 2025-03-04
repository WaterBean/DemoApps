//
//  LikeListViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 3/4/25.
//

import UIKit
import SnapKit
import RealmSwift
import RxCocoa
import RxSwift

final class LikeListViewController: UIViewController {
    
    private let list = try! Realm().objects(ItemData.self).sorted(byKeyPath: "id", ascending: true)
    lazy var itemList = Array( list.map { Item(itemData: $0) } )
    lazy var filtered = itemList {
        didSet {
            print(filtered)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        //        bind()
    }
    
    //    private func bind() {
    //
    //    }
    
    private lazy var searchBar = {
        let bar = UISearchBar()
        bar.placeholder = "상품명이나 쇼핑몰 이름을 검색"
        bar.delegate = self
        return bar
    }()
    
    private lazy var collectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-48)/2, height: 220)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCollectionViewCell")
        view.delegate = self
        view.dataSource = self
        view.backgroundColor = .clear
        return view
    }()
    
    private func configureUI() {
        view.addSubview(searchBar)
        view.addSubview(collectionView)
        searchBar.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
}


extension LikeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filtered.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = filtered[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.configureCell(item: item)
        return cell
    }
    
    
}


extension LikeListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(#function)
        if !searchText.isEmpty {
            let data = itemList
                .filter {
                    $0.title.contains(searchText)
                    || $0.mallName.contains(searchText)
                }
            filtered = data
        } else {
            filtered = Array(itemList)
        }
        collectionView.reloadData()
    }
    
    
}
