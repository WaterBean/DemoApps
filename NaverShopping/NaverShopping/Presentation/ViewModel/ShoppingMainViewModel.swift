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
        let searchButtonClicked: ControlEvent<Void>
        let searchText: ControlProperty<String>
    }
    
    struct Output {
        let searchResult: PublishRelay<Result<String, SearchError>>
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
            searchResult: searchResult
        )
    }
    
    private func checkNetworkStatus() -> Bool {
        switch NetworkManager.shared.status {
        case .satisfied: true
        default: false
        }
    }
    
}

enum SearchError: Error {
    case networkDisconnected
    case minimumQueryLengthLimited
}

extension SearchError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .networkDisconnected:
            "네트워크 연결 불가"
        case .minimumQueryLengthLimited:
            "2자 이상 입력"
        }
    }
    
    var failureReason: String? {
        switch self {
        case .networkDisconnected:
            "와이파이나 데이터 연결을 확인해보세요."
        case .minimumQueryLengthLimited:
            "두글자 이상 입력해주세요"
        }
    }
    
    
}
