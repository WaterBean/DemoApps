//
//  ReusableViewProtocol.swift
//  TravelProject
//
//  Created by 한수빈 on 1/11/25.
//

import UIKit


/// 재사용 뷰 요구사항
protocol Reusable: AnyObject {
    static var identifier: String { get }
}


extension UICollectionViewCell: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UITableViewCell: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
    
}

extension UIViewController: Reusable {
    static var identifier: String {
        return String(describing: self)
    }
    
}
