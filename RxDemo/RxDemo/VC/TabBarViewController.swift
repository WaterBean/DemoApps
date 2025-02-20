//
//  TabBarVC.swift
//  RxDemo
//
//  Created by 한수빈 on 2/19/25.
//

import UIKit

final class TabBarViewController: UITabBarController {

    private let simpletable = {
        let vc = SimpleTableViewExampleViewController()
        vc.tabBarItem.image = UIImage(systemName: "1.circle")
        vc.tabBarItem.title = "테이블뷰"
        vc.tabBarItem.badgeColor = .red
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    private let number = {
        let vc = NumbersViewController()
        vc.tabBarItem.image = UIImage(systemName: "2.circle")
        vc.tabBarItem.title = "넘버스"
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    private let simplevalid = {
        let vc = SimpleValidationViewController()
        vc.tabBarItem.image = UIImage(systemName: "3.circle")
        vc.tabBarItem.title = "검증"
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()

    private let birth = {
        let vc = BirthdayViewController()
        vc.tabBarItem.image = UIImage(systemName: "4.circle")
        vc.tabBarItem.title = "생일"
        let nav = UINavigationController(rootViewController: vc)
        return nav
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setViewControllers([simpletable, number, simplevalid, birth], animated: true)
    }
    
    
}
