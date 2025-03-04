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
    
    var realm = try! Realm()
    var list: Results<ItemData>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        list = realm.objects(ItemData.self).sorted(byKeyPath: "id", ascending: true)
//        bind()
    }
//    
//    private func bind() {
//        
//    }
    
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
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    
    
}


extension LikeListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = Item(itemData: list[indexPath.item])
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as! ItemCollectionViewCell
        cell.configureCell(item: item)
        return cell
    }
    
    
}
