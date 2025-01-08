//
//  UITableViewCell + Extension.swift
//  TravelProject
//
//  Created by 한수빈 on 1/6/25.
//

import UIKit


// UITableViewCell을 그대로 사용하며 viewWithTag를 활용해 코드를 작성한 상태에서 억지로 책임을 나누려하니 다른 TableView에서는 필요없는 계산속성과 메서드를 추가해야만 함
// 결과적으로 범용성 없는 extension, 명확하지 않은 책임 분리가 되어버림
extension UITableViewCell {
            
    enum Tag: Int {
        case checkbox = 1
        case contents = 2
        case star = 3
        case cellBackgroundView = 4
    }
    static func getDefaultIdentifier()-> String {
        return "cell"
    }
        var checkbox: UIImageView?  {
        viewWithTag(Tag.checkbox.rawValue) as? UIImageView
    }
    var contents: UILabel?  {
        viewWithTag(Tag.contents.rawValue) as? UILabel
    }
    var star: UIImageView?  {
        viewWithTag(Tag.star.rawValue) as? UIImageView
    }
    var cellBackgroundView: UIView?  {
        viewWithTag(Tag.cellBackgroundView.rawValue)
    }
    

    func configureUIForShoppingTableViewCell(data: ShoppingItem) {
        backgroundColor = .white
        
        checkbox?.isUserInteractionEnabled = true
        star?.isUserInteractionEnabled = true
                
        checkbox?.image = UIImage(systemName: data.isChecked ? "checkmark.square.fill" : "checkmark.square")
        checkbox?.tintColor = .black

        star?.image = UIImage(systemName: data.isStarred ? "star.fill" : "star")
        star?.tintColor = .black
        
        contents?.text = data.contents
        
        cellBackgroundView?.backgroundColor = .systemGray6
        cellBackgroundView?.clipsToBounds = true
        cellBackgroundView?.layer.cornerRadius = 4

    }
}
