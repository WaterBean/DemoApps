//
//  URLSchemeManager.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/16/25.
//

import UIKit

final class URLSchemeManager {
    static let shared = URLSchemeManager()
    private init() { }
    func openSystemSetting(){
        UIApplication.shared.open(URL(string: "App-prefs://")!)
    }
}
