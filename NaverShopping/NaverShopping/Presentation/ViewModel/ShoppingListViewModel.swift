//
//  ShoppingListViewModel.swift
//  NaverShopping
//
//  Created by 한수빈 on 2/6/25.
//

import Foundation
import RxCocoa
import RxDataSources
import RxSwift

final class ShoppingListViewModel: BaseViewModel {
    
    struct Input {
        let simButtonTapped: Observable<SortButton.SortOption>
        let dateButtonTapped: Observable<SortButton.SortOption>
        let dscButtonTapped: Observable<SortButton.SortOption>
        let ascButtonTapped: Observable<SortButton.SortOption>
        let itemTapped: ControlEvent<IndexPath>
    }
    
    struct Output {
        let query: Observable<String>
        let searchList: BehaviorRelay<[Item]>
        let searchListTotal: BehaviorRelay<String>
        let buttonStatus: BehaviorRelay<SortButton.SortOption>
        let someError: PublishRelay<NetworkError>
        let toItemDetail: PublishRelay<String>
    }
    
    var disposeBag = DisposeBag()
    private let query: String
    //    lazy var enableStartRange = 1...(item.value.total)
    
    init(query: String) {
        self.query = query
    }
    
    func transform(input: Input) -> Output {
        let query = Observable.just(query)
        let searchList = BehaviorRelay(value: [Item]())
        let searchListTotal = BehaviorRelay(value: "0 개의 검색 결과")
        let buttonStatus = BehaviorRelay(value: SortButton.SortOption.sim)
        let someError = PublishRelay<NetworkError>()
        let toItemDetail = PublishRelay<String>()
        
        Observable.merge(
            input.simButtonTapped,
            input.dateButtonTapped,
            input.dscButtonTapped,
            input.ascButtonTapped
        )
        .bind { buttonStatus.accept($0) }
        .disposed(by: disposeBag)
        
        buttonStatus
            .withUnretained(self)
            .flatMap { owner, option in
                NetworkManager.shared.fetchNaverShopping(
                    query: owner.query,
                    sort: option.fetchString
                )
            }
            .catch { error in
                someError.accept(error as! NetworkError)
                return .empty()
            }
            .subscribe(with: self) { owner, response in
                searchList.accept(response.items)
                searchListTotal.accept("\(response.total.formatted(.number)) 개의 검색 결과")
            }
            .disposed(by: disposeBag)
        
        input.itemTapped
            .map { searchList.value[$0.item].link }
            .bind { toItemDetail.accept($0) }
            .disposed(by: disposeBag)
        
        return Output(
            query: query,
            searchList: searchList,
            searchListTotal: searchListTotal,
            buttonStatus: buttonStatus,
            someError: someError,
            toItemDetail: toItemDetail
        )
    }
    
    
}

