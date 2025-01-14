//
//  NPayViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 1/13/25.
//

import UIKit
import SnapKit

final class NPayViewController: UIViewController {

    let segmentedControl = {
        let seg = UISegmentedControl()
        seg.insertSegment(withTitle: "멤버십", at: 0, animated: true)
        seg.insertSegment(withTitle: "현장결제", at: 1, animated: true)
        seg.insertSegment(withTitle: "쿠폰", at: 2, animated: true)
        seg.tintColor = .systemGray2
        return seg
    }()
    
    let backgroundView = {
        let view = UIView()
        view.backgroundColor = .white
        view.cornerRadius = 12
        view.clipsToBounds = true
        return view
    }()
    
    let nPayImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "npay")
        image.contentMode = .scaleAspectFill
        return image
    }()
    let xMarkImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.image = UIImage(systemName: "xmark")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let domesticOrForeignButton = {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(stringLiteral: "국내 ▼")
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        config.baseForegroundColor = .systemGray6
        let button = UIButton()
        button.configuration = config
        return button
    }()
    
    let lockImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "npay_unlock")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.text = "한 번만 인증하고\n비밀번호 없이 결제하세요"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.numberOfLines = 2
        label.textColor = .black
        return label
    }()
    
    let useDirectPayButton = {
        var config = UIButton.Configuration.plain()
        config.attributedTitle = AttributedString(stringLiteral: "바로결제 사용하기")
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        config.baseForegroundColor = .systemGray6
        config.image = .checkmark.withTintColor(.systemGreen, renderingMode: .alwaysOriginal)
        let button = UIButton()
        button.configuration = config
        button.configuration?.imagePadding = 6
        
        return button
    }()
    
    let confirmButton = {
        var config = UIButton.Configuration.filled()
        config.attributedTitle = AttributedString(stringLiteral: "확인")
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        config.baseBackgroundColor = .systemGreen
        config.cornerStyle = .capsule
        
        let button = UIButton()
        button.configuration = config
        button.configuration?.imagePadding = 6
        
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy(target: self, views: [segmentedControl, backgroundView])
        
        configureHierarchy(target: backgroundView, views: [nPayImageView, domesticOrForeignButton, xMarkImageView, lockImageView, descriptionLabel, useDirectPayButton, confirmButton])
        
        segmentedControl.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(34)
        }
        
        backgroundView.snp.makeConstraints {
            $0.top.equalTo(segmentedControl.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(20)
            $0.height.equalTo(400)
        }
        
        nPayImageView.snp.makeConstraints {
            $0.top.equalTo(24)
            $0.leading.equalTo(12)
            $0.width.equalTo(70)
            $0.height.equalTo(20)
        }
        
        
        xMarkImageView.snp.makeConstraints {
            $0.top.equalTo(20)
            $0.trailing.equalTo(-20)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        domesticOrForeignButton.snp.makeConstraints {
            $0.top.equalTo(nPayImageView.snp.top)
            $0.leading.equalTo(nPayImageView.snp.trailing).offset(-10)
            $0.centerY.equalTo(nPayImageView.snp.centerY)
            $0.height.equalTo(12)
        }
        
        lockImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.centerX.equalToSuperview()
            $0.size.equalTo(100)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(lockImageView.snp.bottom).offset(20)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(20)
        }
        
        useDirectPayButton.snp.makeConstraints {
            $0.bottom.equalTo(confirmButton.snp.top).offset(-20)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(30)
        }
        
        confirmButton.snp.makeConstraints {
            $0.bottom.equalToSuperview().offset(-20)
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.height.equalTo(44)
        }
        
        
    }

}

#Preview {
    NPayViewController()
}
