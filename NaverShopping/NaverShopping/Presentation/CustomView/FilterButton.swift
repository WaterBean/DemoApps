//
//  FilterButton.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/16/25.
//
import UIKit

final class FilterButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuration = UIButton.Configuration.bordered()
        configurationUpdateHandler = configHandler(_:)
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
    
    func configHandler(_ button: UIButton)-> Void {
        switch button.state {
        case .selected:
            button.configuration?.background.backgroundColor = .white
            button.configuration?.baseForegroundColor = .black
        case .normal:
            button.configuration?.background.backgroundColor = .black
            button.configuration?.baseForegroundColor = .white
        default : break
        }

    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
