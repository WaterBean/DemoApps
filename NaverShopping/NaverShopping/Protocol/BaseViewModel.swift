//
//  BaseViewModel.swift
//  NaverShopping
//
//  Created by 한수빈 on 2/25/25.
//

import Foundation
import RxSwift

protocol BaseViewModel {
    
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
    
}
