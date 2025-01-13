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
        config.image = UIImage(systemName: "arrowtriangle.down.fill")
        config.title = "국내"
        config.baseForegroundColor = .systemGray4
        config.imagePlacement = .trailing
        let button = UIButton()
        button.configuration = config
        return button
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView(target: self, views: [segmentedControl, backgroundView])
        
        addSubView(target: backgroundView, views: [nPayImageView, domesticOrForeignButton, xMarkImageView])
        
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
            $0.top.leading.equalTo(16)
            $0.width.equalTo(70)
            $0.height.equalTo(20)
        }
        
        
        xMarkImageView.snp.makeConstraints {
            $0.top.equalTo(16)
            $0.trailing.equalTo(-16)
            $0.width.equalTo(24)
            $0.height.equalTo(24)
        }
        
        domesticOrForeignButton.snp.makeConstraints {
            $0.top.equalTo(16)
            $0.leading.equalTo(nPayImageView.snp.trailing).offset(10)
            $0.width.equalTo(44)
            $0.height.equalTo(44)
        }
        
        
        
        
    }

}

#Preview {
    NPayViewController()
}
