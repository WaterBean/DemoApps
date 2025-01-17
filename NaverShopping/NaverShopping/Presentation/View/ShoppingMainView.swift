//
//  ShoppingMainView.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/16/25.
//

import UIKit
import SnapKit


final class ShoppingMainView: BaseView {
    let searchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "브랜드, 상품, 프로필, 태그 등"
        searchBar.barStyle = .black
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private let backgroundImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "background-image")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let label = {
        let label = UILabel()
        label.text = "쇼핑 하구팡"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 24, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    override func configureHierarchy() {
        addSubview(searchBar)
        addSubview(backgroundImageView)
        addSubview(label)
    }
    
    
    override func configureLayout() {
        searchBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(safeAreaLayoutGuide)
            $0.height.equalTo(44)
        }
        
        backgroundImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalTo(200)
        }
        
        label.snp.makeConstraints {
            $0.top.equalTo(backgroundImageView.snp.bottom)
            $0.horizontalEdges.equalToSuperview()
        }
    }
    
    override func configureView() {

    }
    
    
    
}
