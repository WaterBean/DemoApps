//
//  SignUpViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 12/26/24.
//

import UIKit

class SignUpViewController: UIViewController {

    @IBOutlet var emailOrTelephoneTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet var nicknameTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var referralcodeTextField: UITextField!
    @IBOutlet var signUpButton: UIButton!
    @IBOutlet var additionalInformationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailOrTelephoneTextField.attributedPlaceholder = NSAttributedString(string: "이메일 주소 또는 전화번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        emailOrTelephoneTextField.textColor = .white
        emailOrTelephoneTextField.keyboardType = .emailAddress
        emailOrTelephoneTextField.textAlignment = .center
        emailOrTelephoneTextField.borderStyle = .roundedRect
        emailOrTelephoneTextField.backgroundColor = .gray
        emailOrTelephoneTextField.enablesReturnKeyAutomatically = true
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "비밀번호", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        passwordTextField.textColor = .white
        passwordTextField.keyboardType = .default
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textAlignment = .center
        passwordTextField.borderStyle = .roundedRect
        passwordTextField.backgroundColor = .gray
        passwordTextField.enablesReturnKeyAutomatically = true

        nicknameTextField.attributedPlaceholder = NSAttributedString(string: "닉네임", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        nicknameTextField.textColor = .white
        nicknameTextField.keyboardType = .default
        nicknameTextField.textAlignment = .center
        nicknameTextField.borderStyle = .roundedRect
        nicknameTextField.backgroundColor = .gray
        nicknameTextField.enablesReturnKeyAutomatically = true

        locationTextField.attributedPlaceholder = NSAttributedString(string: "위치", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        locationTextField.textColor = .white
        locationTextField.keyboardType = .default
        locationTextField.textAlignment = .center
        locationTextField.borderStyle = .roundedRect
        locationTextField.backgroundColor = .gray

        referralcodeTextField.attributedPlaceholder = NSAttributedString(string: "추천 코드 입력", attributes: [NSAttributedString.Key.foregroundColor : UIColor.white])
        referralcodeTextField.textColor = .white
        referralcodeTextField.keyboardType = .default
        referralcodeTextField.textAlignment = .center
        referralcodeTextField.borderStyle = .roundedRect
        referralcodeTextField.backgroundColor = .gray
        
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.layer.backgroundColor = UIColor.white.cgColor
        signUpButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 6
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
        
        additionalInformationSwitch.setOn(true, animated: true)
        additionalInformationSwitch.onTintColor = .systemPink
        additionalInformationSwitch.thumbTintColor = .white
    }

    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
    }
    
}
