//
//  ShoppingListViewModel.swift
//  NaverShopping
//
//  Created by 한수빈 on 2/6/25.
//

import Foundation

final class ShoppingListViewModel {
    
    let inputFilterButtonTapped: Observable<SortButton.SortOption> = Observable(.sim)
    let inputViewDidLoad: Observable<Void?> = Observable(nil)
    let outputTotalCount: Observable<String> = Observable("")
    let outputViewDidLoad: Observable<String> = Observable("")
    let outputFilterButtonTapped: Observable<(option: SortButton.SortOption, isNetworkConnected: Bool)> = Observable((.sim, true))
    
    let item = Observable(ItemResponse(total: 0, start: 0, items: []))
    
    lazy var enableStartRange = 1...(item.value.total)
    var query: String = ""


    init() {
        inputViewDidLoad.lazyBind { [weak self] _ in
            guard let self else { return }
            self.search(self.query)
        }
        
        inputFilterButtonTapped.lazyBind { [weak self] option in
            self?.convertSort(option)
        }
    }
    
    private func search(_ query: String, sort: SortButton.SortOption = .sim) {
        NetworkManager.shared.fetchNaverShopping(query: query, sort: sort.fetchString) { response in
            switch response {
            case .success(let success):
                self.item.value = success
                let total = success.total.formatted(.number)
                self.outputTotalCount.value = "\(total) 개의 검색 결과"
                print(success)
            case .failure(let failure):
                print(failure)
            }
        }
    }
    
    private func convertSort(_ option: SortButton.SortOption) {
        if NetworkManager.shared.status == .satisfied {
            if self.item.value.total == 0 {
                outputFilterButtonTapped.value = (option, false)
                return
            }
            outputFilterButtonTapped.value = (option, true)
            search(self.query, sort: option)
        } else {
            outputFilterButtonTapped.value = (option, false)
        }

    }
    
}
