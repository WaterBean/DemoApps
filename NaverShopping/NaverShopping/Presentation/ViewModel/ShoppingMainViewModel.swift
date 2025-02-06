//
//  ShoppingMainViewModel.swift
//  NaverShopping
//
//  Created by 한수빈 on 2/6/25.
//

import Foundation

final class ShoppingMainViewModel {
    
    let inputSearchButtonTapped: Observable<String?> = Observable(nil)
    let outputSearch: Observable<(query: String?, isNetworkConnected: Bool)> = Observable((nil, false))
    
    init() {
        inputSearchButtonTapped.lazyBind { [weak self] text in
            self?.search(text)
        }
    }
    
    private func search(_ text: String?) {
        switch NetworkManager.shared.status {
        case .satisfied:
            guard let text = text?.trimmingCharacters(in: .whitespacesAndNewlines),
                    text.count >= 2 else {
                outputSearch.value = (nil, true)
                return
            }
            outputSearch.value = (text, true)
        default:
            outputSearch.value = (nil, false)
        }
    }
    
}
