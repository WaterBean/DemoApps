//
//  SignUpViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 12/26/24.
//

import UIKit

final class SignUpViewController: UIViewController {
    
    @IBOutlet private var emailOrTelephoneTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var nicknameTextField: UITextField!
    @IBOutlet private var locationTextField: UITextField!
    @IBOutlet private var referralcodeTextField: UITextField!
    @IBOutlet private var signUpButton: UIButton!
    @IBOutlet private var additionalInformationSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField(emailOrTelephoneTextField, placeHolderText: "이메일 주소 또는 전화번호", keyboardType: .emailAddress)
        configureTextField(passwordTextField, placeHolderText: "비밀번호", isSecureEntry: true)
        configureTextField(nicknameTextField, placeHolderText: "닉네임")
        configureTextField(locationTextField, placeHolderText: "위치", enablesReturnKeyAutomatically: false)
        configureTextField(referralcodeTextField, placeHolderText: "추천 코드 입력", keyboardType: .numberPad, enablesReturnKeyAutomatically: false)
        
        configureButton()
        configureSwitch()
    }
    
    private func configureTextField(_ textField: UITextField, textColor: UIColor = .white, backgroudColor: UIColor = .gray, borderStyle: UITextField.BorderStyle = .roundedRect, textAlignment: NSTextAlignment = .center, placeHolderText: String, placeHolderColor: UIColor = .white, keyboardType: UIKeyboardType = .default, isSecureEntry: Bool = false, enablesReturnKeyAutomatically: Bool = true) {
        textField.textColor = textColor
        textField.backgroundColor = backgroudColor
        textField.borderStyle = borderStyle
        textField.textAlignment = textAlignment
        textField.attributedPlaceholder = NSAttributedString(string: placeHolderText, attributes: [NSAttributedString.Key.foregroundColor : placeHolderColor])
        textField.keyboardType = keyboardType
        textField.isSecureTextEntry = isSecureEntry
        textField.enablesReturnKeyAutomatically = enablesReturnKeyAutomatically
    }
    
    private func configureSwitch() {
        additionalInformationSwitch.setOn(true, animated: true)
        additionalInformationSwitch.onTintColor = .systemPink
        additionalInformationSwitch.thumbTintColor = .white
    }
    
    private func configureButton() {
        signUpButton.setTitle("회원가입", for: .normal)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.layer.backgroundColor = UIColor.white.cgColor
        signUpButton.clipsToBounds = true
        signUpButton.layer.cornerRadius = 6
        signUpButton.titleLabel?.font = .systemFont(ofSize: 14, weight: .bold)
    }
    
    
    private func validateEmailOrTelephone() -> Bool {
        let isValid = emailOrTelephoneTextField.hasText ? true : false
        emailOrTelephoneTextField.textColor = isValid ? .white : .red
        return isValid
    }
    
    private func validatePassword() -> Bool {
        guard let password = passwordTextField.text else { return false }
        let isValid = password.count >= 6 ? true : false
        passwordTextField.textColor = isValid ? .white : .red
        return isValid
    }
    
    private func validateReferralCode() -> Bool {
        guard let referralcode = referralcodeTextField.text else { return false }
        let isValid = referralcode.allSatisfy { $0.isNumber } ? true : false
        referralcodeTextField.textColor = isValid ? .white : .red
        return isValid
    }
    
    @IBAction private func signUpButtonTapped(_ sender: UIButton) {
        view.endEditing(true)
        
        let isValidEmailOrTelephone = validateEmailOrTelephone()
        let isValidPassword = validatePassword()
        let isValidReferralCode = validateReferralCode()
        
        if isValidEmailOrTelephone && isValidPassword && isValidReferralCode {
            // TODO: - 회원가입 성공로직
            print("회원가입 성공")
        } else {
            // TODO: - 회원가입 실패로직
            print("회원가입 실패")
        }
    }
    
    @IBAction private func hideKeyboardAction(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
        
    }
    
}
