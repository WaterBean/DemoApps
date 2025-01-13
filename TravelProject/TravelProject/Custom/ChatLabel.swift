//
//  ChatLabel.swift
//  TravelProject
//
//  Created by 한수빈 on 1/12/25.
//

import UIKit

final class ChatLabel: UILabel {
    
    var topInset: CGFloat = 8.0
    var bottomInset: CGFloat = 8.0
    var leftInset: CGFloat = 8.0
    var rightInset: CGFloat = 8.0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLabel()
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupLabel()
    }
    
    private func setupLabel() {
        numberOfLines = 0
        layer.borderWidth = 1
        layer.cornerRadius = 10
        layer.borderColor = UIColor.systemGray3.cgColor
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }

}
