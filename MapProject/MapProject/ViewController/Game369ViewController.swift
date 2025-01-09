//
//  Game369ViewController.swift
//  MapProject
//
//  Created by 한수빈 on 1/8/25.
//

import UIKit

final class Game369ViewController: UIViewController, Presentable {

    
    var list: [Int] = Array(1...100).reversed() {
        didSet {
            print(list)
        }
    }
    var filteredList: [Int] = []
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var textView: UITextView!
    @IBOutlet var numberSelectTextField: UITextField!
    @IBOutlet var resultLabel: UILabel!
    let pickerView = UIPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupDelegate()
        
    }
    
    func configureUI() {
        titleLabel.text = "369게임"
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.textAlignment = .center
        
        resultLabel.text = "숫자 입력"
        resultLabel.font = .boldSystemFont(ofSize: 32)
        resultLabel.textAlignment = .center
        resultLabel.numberOfLines = 2
        
        numberSelectTextField.borderStyle = .line
        numberSelectTextField.textAlignment = .center
        numberSelectTextField.attributedPlaceholder = NSAttributedString(string: "최대 숫자를 입력해주세요", attributes: [.font: UIFont.systemFont(ofSize: 24)])
        numberSelectTextField.inputView = pickerView

        
        textView.isEditable = false
        
    }
    
    func setupDelegate() {
        pickerView.delegate = self
        pickerView.dataSource = self
    }
    
    func game369Start(maxNumber: Int) -> (String, Int) {
        var result = ""
        var clapCount = 0
        
        for number in 1...maxNumber {
            let numberString = String(number)
            let claps = numberString.filter { "369".contains($0) }.count
            
            if claps > 0 {
                result += String(repeating: "👏", count: claps)
                clapCount += claps
            } else {
                result += "\(number)"
            }
            
            if number != maxNumber {
                result += ", "
            }
        }
        
        return (result, clapCount)
    }
    
}

extension Game369ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return list.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(list[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let number = Int(list[row])
        print(#function)
        let (result, clapCount) = game369Start(maxNumber: number)
        
        textView.text = result
        resultLabel.text = "숫자 \(number)까지 총 박수는 \(clapCount)번 입니다."
    }
    
}
