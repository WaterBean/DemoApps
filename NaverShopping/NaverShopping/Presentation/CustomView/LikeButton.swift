//
//  LikeButton.swift
//  NaverShopping
//
//  Created by 한수빈 on 3/4/25.
//

import UIKit
import RealmSwift

final class LikeButton: UIButton {
    
    var id: String {
        didSet {
            let data = try! Realm().objects(ItemData.self).filter { $0.id == self.id }
            isSelected = !(data.isEmpty)
        }
    }
    
    init(id: String) {
        self.id = id
        super.init(frame: .zero)
        changesSelectionAsPrimaryAction = true
        configuration = UIButton.Configuration.plain()
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
