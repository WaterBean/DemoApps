//
//  UITextField+Extension.swift
//  MovieProject
//
//  Created by 한수빈 on 1/13/25.
//

import UIKit

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor, underlineWidth: CGFloat) {
        let border = CALayer()
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.height, width: viewSize, height: underlineWidth)
        border.borderWidth = underlineWidth
        self.layer.addSublayer(border)
    }
}
