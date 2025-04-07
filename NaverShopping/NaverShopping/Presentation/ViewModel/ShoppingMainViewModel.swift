//
//  ShoppingMainViewModel.swift
//  NaverShopping
//
//  Created by 한수빈 on 2/6/25.
//

import Foundation
import RxCocoa
import RxSwift

final class ShoppingMainViewModel: BaseViewModel {
    
    struct Input {
        let likeListButtonTap: ControlEvent<Void>
        let wishListButtonTap: ControlEvent<Void>
        let searchButtonClicked: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let searchResult: PublishRelay<Result<String, SearchError>>
        let wishList: Driver<Void>
        let likeList: Driver<Void>
    }
    
    var disposeBag = DisposeBag()
    
    func transform(input: Input) -> Output {
        
        let searchResult = PublishRelay<Result<String, SearchError>>()
        
        input.searchButtonClicked
            .withLatestFrom(input.searchText)
            .map { $0.trimmingCharacters(in: .whitespacesAndNewlines) }
            .map { text in
                return text.count >= 2 ? text : ""
            }
            .debug()
            .bind(with: self) { owner, text in
                if !(owner.checkNetworkStatus()) {
                    searchResult.accept(.failure(.networkDisconnected))
                } else if text.isEmpty {
                    searchResult.accept(.failure(.minimumQueryLengthLimited))
                } else {
                    searchResult.accept(.success(text))
                }
            }
            .disposed(by: disposeBag)
        
                
        return Output(
            searchResult: searchResult,
            wishList: input.wishListButtonTap.asDriver(),
            likeList: input.likeListButtonTap.asDriver()

        )
    }
    
    private func checkNetworkStatus() -> Bool {
        switch NetworkManager.shared.status {
        case .satisfied: true
        default: false
        }
    }
    
}
