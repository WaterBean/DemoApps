//
//  SimpleValidationViewController.swift
//  RxDemo
//
//  Created by 한수빈 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class SimpleValidationViewController: UIViewController {

    private let disposeBag = DisposeBag()
    private let minimalUsernameLength = 5
    private let minimalPasswordLength = 5
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    private func bind() {
        let usernameValid = usernameTextField.rx.text.orEmpty
            .map { [weak self] in
                guard let self else { return false }
                return $0.count >= minimalUsernameLength
            }
            .share(replay: 1)
            
        let passwordValid = passwordTextField.rx.text.orEmpty
            .map { [weak self] in
                guard let self else { return false }
                return $0.count >= minimalPasswordLength
            }
            .share(replay: 1)
        
        let everythingValid = Observable.combineLatest(usernameValid, passwordValid) { $0 && $1 }
            .share(replay: 1)
        
        usernameValid
            .bind(to: usernameValidLabel.rx.isHidden, passwordTextField.rx.isEnabled)
            .disposed(by: disposeBag)
      
        passwordValid
            .bind(to: passwordValidLabel.rx.isHidden)
            .disposed(by: disposeBag)
        
        everythingValid
            .bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
        button.rx.tap
            .subscribe(with: self) { owner, _  in Alert.simpleAlert(owner: owner, "가입 완료") }
            .disposed(by: disposeBag)
            
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        [usernameLabel, usernameTextField, usernameValidLabel, passwordLabel, passwordValidLabel, passwordTextField, button].forEach {
            view.addSubview($0)
        }
        usernameLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        usernameTextField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(usernameLabel.snp.bottom).offset(16)
        }

        usernameValidLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(usernameTextField.snp.bottom).offset(16)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(usernameValidLabel.snp.bottom).offset(16)
        }
        
        passwordTextField.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(passwordLabel.snp.bottom).offset(16)
        }

        passwordValidLabel.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(passwordTextField.snp.bottom).offset(16)
        }
        
        button.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(passwordValidLabel.snp.bottom).offset(16)
        }
        
        [usernameTextField, passwordTextField].forEach {
            $0.borderStyle = .roundedRect
        }
        
    }
    
    private let stackView = UIStackView()
    private let usernameLabel = {
        let label = UILabel()
        label.text = "Username"
        return label
    }()
    private let usernameTextField = UITextField()
    private lazy var usernameValidLabel = {
        let label = UILabel()
        label.text = "username은 \(minimalUsernameLength)자 이상이어야 합니다."
        label.textColor = .red
        return label
    }()
    private let passwordLabel = {
        let label = UILabel()
        label.text = "Password"
        return label
    }()
    private let passwordTextField = UITextField()
    private lazy var passwordValidLabel = {
        let label = UILabel()
        label.text = "password은 \(minimalUsernameLength)자 이상이어야 합니다."
        label.textColor = .red
        return label
    }()
    private let button = {
        let button = UIButton()
        button.setTitle("다음", for: .normal)
        button.setTitle("다음", for: .disabled)
        button.setTitleColor(.blue, for: .normal)
        button.setTitleColor(.red, for: .disabled)
        button.isEnabled = false
        return button
    }()
    
    
}
