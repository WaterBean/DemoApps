//
//  LotteryViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 1/14/25.
//

import UIKit
import SnapKit

final class LotteryViewController: UIViewController {
    
    var list = [String]()
    
    let textField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        return textField
    }()
    
    let descriptionLabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
    }
    
    let pickerView = {
        let picker = UIPickerView()
        
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        pickerView.delegate = self
        
    }

    
}

extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        list.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        list[row]
    }
    
    
}


