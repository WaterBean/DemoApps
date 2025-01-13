//
//  SignUpCodeBaseViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 1/13/25.
//

import UIKit
import SnapKit

final class SignUpCodeBaseViewController: UIViewController {

    let titleLabel = {
        let label = UILabel()
        label.text = "JACKFLIX"
        label.textColor = .red
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 34, weight: .black)
        return label
    }()
    
    let emailTextField = {
        let textfield = SignUpTextField()
        textfield.placeholder = "이메일 또는 전화번호 입력"
        return textfield
    }()
    
    let passWordTextField = {
        let textfield = SignUpTextField()
        textfield.placeholder = "비밀번호"
        return textfield
    }()
    
    let nickNameTextField = {
        let textfield = SignUpTextField()
        textfield.placeholder = "닉네임"
        return textfield
    }()
    
    let locationTextfield = {
        let textfield = SignUpTextField()
        textfield.placeholder = "위치"
        return textfield
    }()
    
    let referralCodeTextField = {
        let textfield = SignUpTextField()
        textfield.placeholder = "추천 코드 입력"
        return textfield
    }()
    
    let signUpButton = {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.attributedTitle = AttributedString("회원가입")
        config.attributedTitle?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        let button = UIButton()
        button.configuration = config
        return button
    }()
    
    let additionalInfoLabel = {
        let label = UILabel()
        label.text = "추가 정보 입력"
        label.textColor = .white
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    let switchControl = {
        let control = UISwitch()
        control.tintColor = .systemPink
        control.isOn = true
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubView(target: self, views: [titleLabel, emailTextField, passWordTextField, nickNameTextField, locationTextfield, referralCodeTextField, signUpButton, additionalInfoLabel, switchControl])
        
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            $0.leadingMargin.equalTo(20)
            $0.trailingMargin.equalTo(-20)
            
        }
        
        emailTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom)
                .offset(150)
            $0.trailing.leading.equalTo(titleLabel)
            $0.height.equalTo(40)
        }
        
        passWordTextField.snp.makeConstraints {
            $0.top.equalTo(emailTextField.snp.bottom)
                .offset(16)
            $0.trailing.leading.equalTo(titleLabel)
            $0.height.equalTo(40)
        }
        
        nickNameTextField.snp.makeConstraints {
            $0.top.equalTo(passWordTextField.snp.bottom)
                .offset(16)
            $0.trailing.leading.equalTo(titleLabel)
            $0.height.equalTo(40)
        }
        
        locationTextfield.snp.makeConstraints {
            $0.top.equalTo(nickNameTextField.snp.bottom)
                .offset(16)
            $0.trailing.leading.equalTo(titleLabel)
            $0.height.equalTo(40)
        }
        
        referralCodeTextField.snp.makeConstraints {
            $0.top.equalTo(locationTextfield.snp.bottom)
                .offset(16)
            $0.trailing.leading.equalTo(titleLabel)
            $0.height.equalTo(40)
        }
        
        signUpButton.snp.makeConstraints {
            $0.top.equalTo(referralCodeTextField.snp.bottom)
                .offset(16)
            $0.trailing.leading.equalTo(titleLabel)
            $0.height.equalTo(44)
        }
        
        additionalInfoLabel.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom)
                .offset(20)
            $0.leading.equalTo(signUpButton)
        
        }
                
        switchControl.snp.makeConstraints {
            $0.top.equalTo(signUpButton.snp.bottom)
                .offset(16)
            $0.trailing.equalTo(titleLabel)
            $0.height.equalTo(44)
        }
        
    }
    
}

final class SignUpTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.font = .systemFont(ofSize: 15, weight: .bold)
        self.textColor = textColor
        self.backgroundColor = .systemGray3
        self.borderStyle = .roundedRect
        self.textAlignment = .center
        self.attributedPlaceholder = NSAttributedString(string: "", attributes: [.foregroundColor : UIColor.white])
        self.keyboardType = .default
        self.enablesReturnKeyAutomatically = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    SignUpCodeBaseViewController()
}
