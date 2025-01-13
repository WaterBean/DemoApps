//
//  TravelTalkViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/10/25.
//

import UIKit

final class TravelTalkViewController: UIViewController, Presentable {

    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet private var collectionView: UICollectionView!
    
    private let list: [ChatRoom] = mockChatList
    private lazy var filteredList: [ChatRoom] = list {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCollectionViewCell()
        configureUIWhenViewDidLoad()
        
    }

    func configureView() {
        navigationItem.title = "TRAVEL TALK"
        
        searchBar.placeholder = "친구 이름을 검색해보세요"
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 90)
        
        collectionView.collectionViewLayout = layout
    }
    
    func setupDelegateAndDatasource() {
        searchBar.delegate = self
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func registerCollectionViewCell() {
        let nib = UINib(nibName: TravelTalkCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TravelTalkCollectionViewCell.identifier)
    }

}


extension TravelTalkViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = filteredList[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TravelTalkCollectionViewCell.identifier, for: indexPath) as? TravelTalkCollectionViewCell else { return TravelTalkCollectionViewCell() }
        cell.configureCell(item)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let item = filteredList[indexPath.item]
        
        let sb = UIStoryboard(name: "TravelTalk", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: ChattingViewController.identifier) as! ChattingViewController
        
        let backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
        vc.navigationItem.title = item.chatroomName
        vc.list = item.chatList
        
        navigationController?.pushViewController(vc, animated: true)

    }
    
}


extension TravelTalkViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        filteredList = list.filter { $0.chatList.contains { $0.user.rawValue.contains( text ) } }
        if searchText == "" { filteredList = list }
        
    }
}
