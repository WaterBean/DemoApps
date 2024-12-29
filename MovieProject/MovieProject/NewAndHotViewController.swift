//
//  NewAndHotViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 12/29/24.
//

import UIKit

final class NewAndHotViewController: UIViewController {
    @IBOutlet var toBeReleasedButton: UIButton!
    @IBOutlet var popularContentButton: UIButton!
    @IBOutlet var topTenSeriesButton: UIButton!
    @IBOutlet var noResultLabel: UILabel!
    
    private func configureButtons(_ buttons: [UIButton?]) {
        buttons.forEach {
            $0?.layer.backgroundColor = UIColor.black.cgColor
            $0?.setTitleColor(.white, for: .normal)
            $0?.layer.cornerRadius = 20
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons = [toBeReleasedButton, popularContentButton, topTenSeriesButton]

        configureButtons(buttons)
        
        noResultLabel.numberOfLines = 2
        
    }
    
    @IBAction func toBeReleasedButtonTapped(_ sender: UIButton) {
        let buttons = [toBeReleasedButton, popularContentButton, topTenSeriesButton]
        
        configureButtons(buttons)
        
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
        
        noResultLabel.text = "이런! 찾으시는 \(sender.currentTitle!) 작품이 없습니다."
    }
    
}
