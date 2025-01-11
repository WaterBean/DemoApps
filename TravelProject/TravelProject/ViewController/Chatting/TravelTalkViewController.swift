//
//  TravelTalkViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/10/25.
//

import UIKit

final class TravelTalkViewController: UIViewController, Presentable {

    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var collectionView: UICollectionView!
    
    var list: [ChatRoom] = mockChatList
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionViewCell()
        configureUIWhenViewDidLoad()
        
    }

    func configureView() {
        
    }
    
    func setupDelegateAndDatasource() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func registerCollectionViewCell() {
        let nib = UINib(nibName: TravelTalkCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TravelTalkCollectionViewCell.identifier)
    }

}


extension TravelTalkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelTalkCollectionViewCell.identifier, for: indexPath) as? TravelTalkCollectionViewCell else { return TravelTalkCollectionViewCell() }
        
        cell.profileImageView.image = UIImage(named: list[indexPath.item].chatroomImage[0])
        cell.nameLabel.text = list[indexPath.item].chatroomName
        cell.recentTalkLabel.text = list[indexPath.item].chatList.first?.message
        cell.dateLabel.text = list[indexPath.item].chatList.first?.date
        
        
        return cell
    }
    
    
}


extension TravelTalkViewController: UISearchBarDelegate {
    
}
