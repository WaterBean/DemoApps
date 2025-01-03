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
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var resetButton: UIButton!
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
        tallTextField.placeholder = "cm단위로 입력하세요"

        weightTextField.borderStyle = .roundedRect
        weightTextField.backgroundColor = .white
        weightTextField.layer.borderColor = UIColor.black.cgColor
        weightTextField.layer.borderWidth = 2
        weightTextField.layer.cornerRadius = 16
        weightTextField.clipsToBounds = true
        weightTextField.frame.size.height = 56
        weightTextField.placeholder = "kg단위로 입력하세요"
        
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
        
        resetButton.setTitle("초기화", for: .normal)
        saveButton.setTitle("저장", for: .normal)
        
        
        randomInputButton.tintColor = .red
        randomInputButton.setTitle("랜덤으로 BMI 계산하기", for: .normal)
        
        nicknameTextField.text = UserDefaults.standard.string(forKey: "nickname")
        tallTextField.text = String(UserDefaults.standard.double(forKey: "tall"))
        weightTextField.text = String(UserDefaults.standard.double(forKey: "weight"))
    }

    func calculateBMI(tall: Double, weight: Double)-> Double {
        return weight / (tall * tall)
    }
    
    func resultOfBMI(bmi: Double)-> String {
        
        let result = switch bmi {
        case 0...18.5: "저체중"
        case 18.5..<22.9: "정상체중"
        case 23.0..<25.0: "과체중"
        case 25.0..<30.0: "위험체중"
        case 30.0..<35.0: "중증도비만"
        case 35.0...: "고도비만"
        default: "edge case"
        }
        return "\(result)" + "이시네요.\nbmi 수치는 " + String(format: "%.1f", bmi) + " 입니다."
    }
    
    func simpleAlertTemplate(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action1 = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action1)
        return alert
    }
    
    func centimeterToMeter(tall: Double)-> Double{
        return tall / 100
    }
    
    func validateTallAndWeight(tall: Double, weight: Double)-> Bool {
        if 40.0...251.0 ~= tall && 2.0...600.0 ~= weight {
            return true
        } else {
            return false
        }
    }
    
    
    @IBAction func resultButtonTapped(_ sender: UIButton) {
        
        if nicknameTextField.text!.isEmpty {
            nicknameTextField.text = "사용자"
        }
        
        guard let tall = Double(tallTextField.text!) ,
              let weight = Double(weightTextField.text!) else {
            let alert = simpleAlertTemplate(title: "숫자를 입력해주세요!", message: "정확한 수치를 입력해야해요.")
            present(alert, animated: true)
            return
        }
        
        let isValid = validateTallAndWeight(tall: tall, weight: weight)
        guard isValid else {
            let alert = simpleAlertTemplate(title: "흠..", message: "키나 몸무게를 잘못 입력하신거 아닌가요?")
            present(alert, animated: true)
            return
        }
        
        let meterTall = centimeterToMeter(tall: tall)
        let bmi = calculateBMI(tall: meterTall, weight: weight)
        let resultofBmi = resultOfBMI(bmi: bmi)

        saveUserData()
        
        let alert = simpleAlertTemplate(title: "\(nicknameTextField.text!)님의 BMI는..!", message: resultofBmi)
        present(alert, animated: true)
        
    }
    
    @IBAction func randomInputButtonTapped(_ sender: UIButton) {
        tallTextField.text = String(Int.random(in: 140...190))
        weightTextField.text = String(Int.random(in: 35...100))
    }
    
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        nicknameTextField.text = ""
        tallTextField.text = ""
        weightTextField.text = ""
    }
    
    private func saveUserData() {
        UserDefaults.standard.set(nicknameTextField.text!, forKey: "nickname")
        UserDefaults.standard.set(tallTextField.text!, forKey: "tall")
        UserDefaults.standard.set(weightTextField.text!, forKey: "weight")
    }
    
    @IBAction func saveButtonTapped(_ sender: UIButton) {
        
        if nicknameTextField.text!.isEmpty {
            nicknameTextField.text = "사용자"
        }
        
        guard let tall = Double(tallTextField.text!) ,
              let weight = Double(weightTextField.text!) else {
            let alert = simpleAlertTemplate(title: "숫자를 입력해주세요!", message: "정확한 수치를 입력해야해요.")
            present(alert, animated: true)
            return
        }
        
        let isValid = validateTallAndWeight(tall: tall, weight: weight)
        guard isValid else {
            let alert = simpleAlertTemplate(title: "흠..", message: "키나 몸무게를 잘못 입력하신거 아닌가요?")
            present(alert, animated: true)
            return
        }
        
        saveUserData()
        
        let alert = simpleAlertTemplate(title: "저장 완료", message: "\(nicknameTextField.text!)님의 키와 몸무게가 성공적으로 저장되었습니다.")
        present(alert, animated: true)

    }
    
    
    
}

