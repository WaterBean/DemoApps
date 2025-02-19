//
//  AdDetailViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/7/25.
//

import UIKit

final class AdDetailViewController: UIViewController {


    @IBOutlet private var titleLabel: UILabel!
    
    var travelInfo: Travel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "광고 화면"
        let leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "xmark"), style: .plain, target: self, action: #selector(dismissAction))
        leftBarButtonItem.tintColor = .black
        navigationItem.leftBarButtonItem = leftBarButtonItem

        titleLabel.font = .boldSystemFont(ofSize: 24)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center

        
        titleLabel.text = travelInfo?.title
    }
    
    @objc private func dismissAction() {
        dismiss(animated: true)
    }


}
