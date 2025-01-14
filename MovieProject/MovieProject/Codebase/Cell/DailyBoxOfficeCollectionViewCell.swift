//
//  DailyBoxOfficeViewCell.swift
//  MovieProject
//
//  Created by 한수빈 on 1/13/25.
//

import UIKit
import SnapKit

final class DailyBoxOfficeCollectionViewCell: UICollectionViewCell {
        
    let rankLabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let titleLabel = {
        let label = UILabel()
        label.text = "엽문4: 더 파이널"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .bold)
        return label
    }()
    
    let dateLabel = {
        let label = UILabel()
        label.text = "2020-02-12"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private let backView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()

    
    private func configureHierarchy() {
        backView.snp.makeConstraints{
            $0.horizontalEdges.equalTo(16)
            $0.verticalEdges.equalToSuperview()
        }
        
        rankLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(6)
            $0.leading.equalToSuperview()
            $0.width.equalTo(50)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(20)
            $0.trailing.equalTo(dateLabel.snp.leading).offset(-10)
            $0.centerY.equalToSuperview()
            
        }
        
        dateLabel.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-20)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(74)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backView)
        backView.addSubview(dateLabel)
        backView.addSubview(titleLabel)
        backView.addSubview(rankLabel)
        
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
