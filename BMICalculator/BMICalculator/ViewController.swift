//
//  ViewController.swift
//  BMICalculator
//
//  Created by 한수빈 on 12/30/24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var tallTextFieldDescriptionLabel: UILabel!
    @IBOutlet var weightTextFieldDescriptionLabel: UILabel!
    @IBOutlet var nicknameLabel: UILabel!
    @IBOutlet var tallTextField: UITextField!
    @IBOutlet var weightTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var randomInputButton: UIButton!
    @IBOutlet var resultButton: UIButton!
    @IBOutlet var imageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.image = UIImage(named: "image")
        imageView.contentMode = .scaleAspectFit
        
        titleLabel.text = "BMI Calculator"
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        descriptionLabel.text = "당신의 BMI 지수를 알려드릴게요."
        descriptionLabel.numberOfLines = 2
        
        nicknameLabel.text = "닉네임이 어떻게 되시나요?"
        tallTextFieldDescriptionLabel.text = "키가 어떻게 되시나요?"
        weightTextFieldDescriptionLabel.text = "몸무게가 어떻게 되시나요?"
        
        tallTextField.borderStyle = .roundedRect
        tallTextField.backgroundColor = .white
        tallTextField.layer.borderColor = UIColor.black.cgColor
        tallTextField.layer.borderWidth = 2
        tallTextField.layer.cornerRadius = 16
        tallTextField.clipsToBounds = true
        tallTextField.frame.size.height = 56

        weightTextField.borderStyle = .roundedRect
        weightTextField.backgroundColor = .white
        weightTextField.layer.borderColor = UIColor.black.cgColor
        weightTextField.layer.borderWidth = 2
        weightTextField.layer.cornerRadius = 16
        weightTextField.clipsToBounds = true
        weightTextField.frame.size.height = 56
        
        nicknameTextField.borderStyle = .roundedRect
        nicknameTextField.backgroundColor = .white
        nicknameTextField.layer.borderColor = UIColor.black.cgColor
        nicknameTextField.layer.borderWidth = 2
        nicknameTextField.layer.cornerRadius = 16
        nicknameTextField.clipsToBounds = true
        nicknameTextField.frame.size.height = 56

        resultButton.setTitle("결과 확인", for: .normal)
        resultButton.backgroundColor = .purple
        resultButton.setTitleColor(.white, for: .normal)
        resultButton.clipsToBounds = true
        resultButton.layer.cornerRadius = 10
        
        randomInputButton.tintColor = .red
        randomInputButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        
    }

    @IBAction func resultButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func randomInputButtonTapped(_ sender: UIButton) {
    }
    
    
}

