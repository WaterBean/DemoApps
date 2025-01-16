//
//  ShoppingListView.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/16/25.
//

import UIKit
import SnapKit

final class ShoppingListView: BaseView {
    let totalNumberLabel = {
        let label = UILabel()
        label.textColor = .green
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    let stackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.spacing = 6
        return stack
    }()
    
    lazy var simButton = {
        let button = SortButton(option: .sim)
        button.isSelected = true
        return button
    }()
    
    lazy var dateButton = {
        let button = SortButton(option: .date)
        return button
    }()
    
    lazy var ascButton = {
        let button = SortButton(option: .asc)
        return button
    }()
    
    lazy var dscButton = {
        let button = SortButton(option: .dsc)
        return button
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-48)/2, height: 220)
        
        return layout
    }())
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(totalNumberLabel)
        addSubview(stackView)
        addSubview(collectionView)
        stackView.addArrangedSubview(simButton)
        stackView.addArrangedSubview(dateButton)
        stackView.addArrangedSubview(dscButton)
        stackView.addArrangedSubview(ascButton)
    }
    
    override func configureLayout() {
        totalNumberLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(safeAreaLayoutGuide).offset(16)
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(totalNumberLabel.snp.bottom).offset(20)
            $0.leading.equalTo(safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
    
    override func configureView() {
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCollectionViewCell")
        collectionView.backgroundColor = .clear
    }
    
    
}
