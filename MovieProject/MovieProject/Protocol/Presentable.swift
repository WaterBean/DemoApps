//
//  Presentable.swift
//  MovieProject
//
//  Created by 한수빈 on 1/13/25.
//

import UIKit

protocol Presentable: UIViewController {
    func configureHierarchy(target: UIViewController, views: [UIView] ) -> Void
    func configureHierarchy(target: UIView, views: [UIView] ) -> Void
    
}

extension UIViewController: Presentable {
    func configureHierarchy(target: UIViewController, views: [UIView] ) -> Void {
        views.forEach {
            target.view.addSubview($0)
        }
    }
    func configureHierarchy(target: UIView, views: [UIView] ) -> Void {
        views.forEach {
            target.addSubview($0)
        }
    }
}

/*
 1. anyobject
 2. some
 3. uiviewcontroller why
 4. how to uiviewcontroller
 */
