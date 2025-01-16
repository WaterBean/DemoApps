//
//  AlertManager.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/16/25.
//
import UIKit

final class AlertManager {
    private init() { }
    
    static func simpleAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel)
        alert.addAction(action)
        return alert
    }

    static func networkNotConnectionAlert(handler: @escaping (UIAlertAction) -> Void) -> UIAlertController {
        let alert = UIAlertController(title: "네트워크 연결 불가", message: "와이파이나 데이터 연결을 확인해주세요.", preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .cancel)
        let action2 = UIAlertAction(title: "설정", style: .default, handler: handler)
        alert.addAction(action)
        alert.addAction(action2)
        return alert
    }
}
