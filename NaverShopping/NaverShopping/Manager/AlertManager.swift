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
}
