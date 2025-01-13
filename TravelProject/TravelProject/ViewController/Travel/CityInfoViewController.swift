//
//  CityInfoViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/7/25.
//

import UIKit

final class CityInfoViewController: UIViewController {
    
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var segmentedControl: UISegmentedControl!
    @IBOutlet private var collectionView: UICollectionView!
    
    
    private let list = CityInfo().city
    private lazy var selectedList = list {
        didSet {
            filteredList = selectedList
        }
    }
    private lazy var filteredList = list {
        didSet {
            collectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        textField.delegate = self
        
        setupCollectionView()
        
        navigationItem.title = "인기 도시"
        
        textField.placeholder = "도시를 검색하세요"
        textField.returnKeyType = .search

        segmentedControl.setTitle("모두", forSegmentAt: 0)
        segmentedControl.setTitle("국내", forSegmentAt: 1)
        segmentedControl.setTitle("해외", forSegmentAt: 2)
    }
    
    private func setupCollectionView() {
        collectionView.register(UINib(nibName: CityInfoCollectionViewCell.identifier, bundle: nil), forCellWithReuseIdentifier: CityInfoCollectionViewCell.identifier)
        
        let layout = UICollectionViewFlowLayout()
        
        let sectionSpacing: CGFloat = 20
        let itemSpacing: CGFloat = 30
        
        // (전체 화면 - 아이템 간격 - 양쪽 섹션 여백) / 2
        let width: CGFloat = (view.frame.width - itemSpacing - (sectionSpacing * 2.0)) / 2.0
        
        // xib 비율에 맞게 조정
        let (itemWidth, itemHeight): (CGFloat, CGFloat) = (width, width * 3.0 / 2.0)
        
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)
        layout.sectionInset = UIEdgeInsets(top: 0, left: sectionSpacing, bottom: 0, right: sectionSpacing)
        
        // item간 간격 설정
        //        layout.minimumLineSpacing = 0
        //        layout.minimumInteritemSpacing = 0
        
        collectionView.collectionViewLayout = layout
    }
    
    @IBAction private func segmentedControlSelected(_ sender: UISegmentedControl) {
        selectedList = switch sender.selectedSegmentIndex {
        case 1: list.filter { $0.domestic_travel }
        case 2: list.filter { !$0.domestic_travel }
        default: list
        }
        
        view.endEditing(true)
    }
    
    private func searchCity(_ keyword: String) {
        if keyword == "" {
            filteredList = selectedList
        } else {
            filteredList = selectedList.filter {
                $0.city_name.contains(keyword) ||
                $0.city_english_name.contains(keyword) ||
                $0.city_english_name.contains(keyword.capitalized) ||
                $0.city_explain.contains(keyword)
            }
        }
    }
    
    
}


// MARK: - CollectionView Delegate, DataSource
extension CityInfoViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        filteredList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let row = filteredList[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CityInfoCollectionViewCell.identifier, for: indexPath) as! CityInfoCollectionViewCell
        guard let keyword = textField.text else { return CityInfoCollectionViewCell() }
        
        cell.configureCell(row: row, keyword: keyword)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
}


// MARK: - TableView Delegate
extension CityInfoViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            searchCity(text)
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let text = textField.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            searchCity(text)
        }
        view.endEditing(true)
        return true
    }
}
