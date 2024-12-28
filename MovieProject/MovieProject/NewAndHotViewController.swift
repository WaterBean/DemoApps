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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let buttons = [toBeReleasedButton, popularContentButton, topTenSeriesButton]

        buttons.forEach {
            $0?.layer.backgroundColor = UIColor.black.cgColor
            $0?.setTitleColor(.white, for: .normal)
            $0?.layer.cornerRadius = 20

        }
    }
    
    @IBAction func toBeReleasedButtonTapped(_ sender: UIButton) {
        let buttons = [toBeReleasedButton, popularContentButton, topTenSeriesButton]
        
        buttons.forEach {
            $0?.layer.backgroundColor = UIColor.black.cgColor
            $0?.setTitleColor(.white, for: .normal)

        }
        sender.backgroundColor = .white
        sender.setTitleColor(.black, for: .normal)
        noResultLabel.text = "이런! 찾으시는 작품이 없습니다."
    }
    
}
