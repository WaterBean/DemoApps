//
//  String+Extension.swift
//  MovieProject
//
//  Created by 한수빈 on 1/14/25.
//

import UIKit

extension String {
    func toAttribute(_ target: String) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(.foregroundColor, value: UIColor.systemYellow, range: (self as NSString).range(of: target))
        attributeString.addAttribute(.font, value: UIFont.systemFont(ofSize: 24, weight: .bold), range: (self as NSString).range(of: target))
        return attributeString
    }

}
