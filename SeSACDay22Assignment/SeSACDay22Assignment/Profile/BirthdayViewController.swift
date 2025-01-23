//
//  BirthdayViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

final class BirthdayViewController: UIViewController {

    let datePicker = UIDatePicker()
    
    weak var delegate: PassDataProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @objc func okButtonTapped() {
        let birthday = datePicker.date.formatted(Date.FormatStyle(date: .numeric))
        delegate?.passBirthday(birthday: birthday)
        navigationController?.popViewController(animated: true)
    }
    
    func configureView() {
        navigationItem.title = "생일"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
        }
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.datePickerMode = .date
    }
}

protocol PassDataProtocol: AnyObject {
    func passBirthday(birthday: String) -> Void
}
