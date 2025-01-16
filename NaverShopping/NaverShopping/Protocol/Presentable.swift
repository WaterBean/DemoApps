//
//  Presentable.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit


protocol Presentable: AnyObject {

    /// view.addSubview()를 통해 계층 구조를 정의하는 함수
    func configureHierarchy()-> Void
    
    /// NSConstraint 혹은 Snapkit으로 뷰를 배치시키는 함수
    func configureLayout() -> Void
    
    /// view의 속성을 다루는 함수
    func configureView() -> Void
}
