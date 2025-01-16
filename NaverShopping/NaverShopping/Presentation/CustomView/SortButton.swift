//
//  FilterButton.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/16/25.
//
import UIKit

final class SortButton: UIButton {
    
    var option: SortOption = .sim
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(option: SortOption) {
        self.init(frame: .zero)
        self.option = option
        var config = UIButton.Configuration.bordered()
        config.title = option.rawValue
        configuration = config
        configurationUpdateHandler = configHandler(_:)
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configHandler(_ button: UIButton) -> Void {
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
    
    enum SortOption: String {
        ///정확도
        case sim = "정확도"
        ///날짜순
        case date = "날짜순"
        ///가격높은순
        case dsc = "가격높은순"
        ///가격낮은순
        case asc = "가격낮은순"
        
        var fetchString: String {
            return String(describing: self)
        }
    }
    
    
}
