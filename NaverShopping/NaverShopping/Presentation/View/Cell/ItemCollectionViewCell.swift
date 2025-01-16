//
//  ItemCollectionViewCell.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit
import Kingfisher
import SnapKit

final class ItemCollectionViewCell: UICollectionViewCell {
    let titleLabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.8, alpha: 1)
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    let itemImage = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    let mallNameLabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    let priceLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(title: String, imageURL: URL?, mallName: String, price: Int) {
        titleLabel.text = title.htmlEscaped
        itemImage.kf.setImage(with: imageURL)
        itemImage.layer.cornerRadius = 12
        mallNameLabel.text = mallName
        priceLabel.text = price.formatted(.number)
    }
}


extension ItemCollectionViewCell: Presentable {
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(itemImage)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(priceLabel)
    }
    
    func configureLayout() {
        itemImage.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.height.equalTo(140)
        }
        
        mallNameLabel.snp.makeConstraints {
            $0.top.equalTo(itemImage.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(itemImage)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(mallNameLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(itemImage)
        }
        
        priceLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(itemImage)
        }
        
    }
    
    func configureView() {
        
    }
    
    
}
