//
//  DailyBoxOfficeViewCell.swift
//  MovieProject
//
//  Created by 한수빈 on 1/13/25.
//

import UIKit
import SnapKit

final class DailyBoxOfficeCollectionViewCell: UICollectionViewCell {
    
    private let backView = {
        return UIView()
    }()
    
    private let rankLabel = {
        let label = UILabel()
        label.text = "1"
        label.textColor = .black
        label.backgroundColor = .white
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let titleLabel = {
        let label = UILabel()
        label.text = "엽문4: 더 파이널"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.text = "2020-02-12"
        label.textColor = .white
        label.font = .systemFont(ofSize: 12)
        return label
    }()
    
    private func cconfigureHierarchy() {
        backView.snp.makeConstraints{
            $0.horizontalEdges.equalTo(16)
            $0.verticalEdges.equalTo(0)
        }
        
        rankLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.width.equalTo(50)
            $0.verticalEdges.equalTo(20)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(rankLabel.snp.trailing).offset(20)
            $0.verticalEdges.equalTo(20)
        }
        
        dateLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing)
            $0.trailing.equalToSuperview().offset(-20)
            $0.verticalEdges.equalTo(20)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(backView)
        backView.addSubview(dateLabel)
        backView.addSubview(titleLabel)
        backView.addSubview(rankLabel)
        
        cconfigureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
