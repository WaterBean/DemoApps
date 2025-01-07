//
//  String+Extension.swift
//  TravelProject
//
//  Created by 한수빈 on 1/7/25.
//

import UIKit

extension String {
    func toAttribute(_ target: String) -> NSMutableAttributedString {
        let attributeString = NSMutableAttributedString(string: self)
        attributeString.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: (self as NSString).range(of: target))
        return attributeString
    }

}
