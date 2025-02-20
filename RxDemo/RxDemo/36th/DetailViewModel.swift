//
//  DetailViewModel.swift
//  RxDemo
//
//  Created by 한수빈 on 2/19/25.
//

import RxCocoa
import RxSwift

final class DetailViewModel {
    
    struct Input {
        let model: Person
    }
    
    struct Output {
        let model: Observable<Person>
    }
    
    func transform(input: Input) -> Output {
        let model = Observable.just(input.model)
        return Output(
            model: model
        )
    }
    
    
}

