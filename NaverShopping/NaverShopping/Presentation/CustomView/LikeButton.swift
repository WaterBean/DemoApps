//
//  LikeButton.swift
//  NaverShopping
//
//  Created by 한수빈 on 3/4/25.
//

import UIKit
import RxCocoa
import RxSwift

final class LikeButton: UIButton {
    
    convenience init() {
        self.init(frame: .zero)
        changesSelectionAsPrimaryAction = true
        var config = UIButton.Configuration.plain()
        configuration = config
        
        configurationUpdateHandler = { button in
            var config = button.configuration
            config?.background.backgroundColor = .white
            config?.cornerStyle = .capsule
            config?.image = button.isSelected
            ? UIImage(
                systemName: "heart.fill",
                withConfiguration:
                    UIImage.SymbolConfiguration(
                        paletteColors: [.black]
                    )
            )
            : UIImage(
                systemName: "heart",
                withConfiguration:
                    UIImage.SymbolConfiguration(
                        paletteColors: [.black]
                    )
            )
            button.configuration = config
        }
    }
    
    
}
