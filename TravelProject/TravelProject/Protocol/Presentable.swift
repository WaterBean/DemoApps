//
//  Presentable.swift
//  TravelProject
//
//  Created by 한수빈 on 1/11/25.
//

import Foundation

/// ViewController 요구사항
protocol Presentable: AnyObject {
    // template Method
    func configureUIWhenViewDidLoad()
    
    func configureView()
    func setupDelegateAndDatasource()
    
}


extension Presentable {
    func configureUIWhenViewDidLoad() {
        configureView()
        setupDelegateAndDatasource()
    }
    
}

