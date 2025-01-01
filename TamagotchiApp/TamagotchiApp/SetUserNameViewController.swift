//
//  SetUserNameViewController.swift
//  TamagotchiApp
//
//  Created by 한수빈 on 1/1/25.
//

import UIKit

final class SetUserNameViewController: UIViewController {

    @IBOutlet var statusLabel: UILabel!
    @IBOutlet var userNameNavigationItem: UINavigationItem!
    @IBOutlet var userNameTextField: UITextField!
    let user = User.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        userNameNavigationItem.title = "대장님 이름 정하기"
        userNameNavigationItem.backButtonTitle = "설정"
        userNameNavigationItem.rightBarButtonItem?.title = "저장"
        
        
        userNameTextField.addBottomLine()
    }


    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        let inputName = userNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if 2...6 ~= inputName.count {
            user.name = inputName
            statusLabel.text = "대장의 이름이 \(inputName)으로 성공적으로 저장"
            statusLabel.textColor = .green
        } else {
            statusLabel.text = "이름은 공백을 제외한 2~6자를 입력하세요."
            statusLabel.textColor = .red
        }
    }
    
    
    @IBAction func textFieldEditingChanged(_ sender: UITextField) {
        let inputName = sender.text!
        if inputName.count > 6 {
            sender.text = String(inputName.prefix(6))
        }
    }
    
}
