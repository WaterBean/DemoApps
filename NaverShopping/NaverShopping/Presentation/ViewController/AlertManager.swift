//
//  AlertManager.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/16/25.
//
import UIKit

final class AlertManager {
    private init() { }
    
    static func moreThanSecondWordPleaseAlert() -> UIAlertController {
        let alert = UIAlertController(title: "조금 더 길게 입력해보세요.", message: "2자 이상 입력해야합니다.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(action)
        return alert
    }
}
