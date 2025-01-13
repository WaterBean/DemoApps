//
//  UITextField+Extension.swift
//  MovieProject
//
//  Created by 한수빈 on 1/13/25.
//

import UIKit

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor) {
        let border = CALayer()
        let width = CGFloat(2)
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.height, width: viewSize, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
}
