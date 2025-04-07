//
//  DetailItemViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 2/27/25.
//

import UIKit
import SnapKit
import WebKit

final class DetailItemViewController: UIViewController {

    private let webView = WKWebView()
    private let url: String
    
    init(url: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        if let url = URL(string: self.url) {
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        } else {
            let url = URL(string: "https://shopping.naver.com/ns/home")!
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }

}
