//
//  UpDownHomeViewController.swift
//  MapProject
//
//  Created by 한수빈 on 1/9/25.
//

import UIKit

final class UpDownHomeViewController: UIViewController, ViewControllerRequirement {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var textField: UITextField!
    @IBOutlet var startButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIWhenViewDidload()
        
    }
    
    
    
    func configureView() {
        
        titleLabel.text = "UP DOWN"
        titleLabel.font = .monospacedSystemFont(ofSize: 48, weight: .bold)
        titleLabel.textAlignment = .center
        
        subTitleLabel.text = "GAME"
        subTitleLabel.font = .systemFont(ofSize: 16)
        subTitleLabel.textAlignment = .center
        
        backgroundImageView.image = .emotion1
        backgroundImageView.contentMode = .scaleAspectFill
        
        textField.placeholder = "숫자 입력"
        textField.borderStyle = .none
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        textField.underlined(viewSize: textField.bounds.width, color: .white)
        
        let attributedString = NSAttributedString(string: "시작하기", attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white] )
        startButton.setAttributedTitle(attributedString, for: .normal)
        startButton.backgroundColor = .black
        
        startButton.addTarget(self, action: #selector(startGameButtonTapped), for: .touchUpInside)
        
        
        view.backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 1.0, alpha: 1)
    }
    
    @objc func startGameButtonTapped(_ sender: UIButton) {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: UpDownGameViewController.identifier) as! UpDownGameViewController
        
        
        guard let stringNumber = textField.text,
        let number = Int(stringNumber) else { return }
        
        vc.userInputMaxNumber = Int(number)
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        
    }
    func setupDelegateAndDatasource() {
        
    }
    
}

extension UITextField {
    func underlined(viewSize: CGFloat, color: UIColor) {
        let border = CALayer()
        let width = CGFloat(1)
        
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 24, y: self.frame.size.height, width: viewSize - 48, height: width)
        border.borderWidth = width
        self.layer.addSublayer(border)
    }
}
