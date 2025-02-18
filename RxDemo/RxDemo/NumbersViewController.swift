//
//  NumbersViewController.swift
//  RxDemo
//
//  Created by 한수빈 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class NumbersViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        bind()
    }
    
    func bind() {
        let number1 = firstTextField.rx.text.orEmpty
        let number2 = secondTextField.rx.text.orEmpty
        let number3 = thirdTextField.rx.text.orEmpty
        
        Observable.combineLatest(number1, number2, number3) { v1, v2, v3 -> Int in
            return (Int(v1) ?? 0) + (Int(v2) ?? 0) + (Int(v3) ?? 0)
        }
        .map { $0.description }
        .bind(to: resultLabel.rx.text)
        .disposed(by: disposeBag)
    }
    
    let firstTextField = UITextField()
    let secondTextField = UITextField()
    let thirdTextField = UITextField()
    let resultLabel = UILabel()
    let stackView = UIStackView()
    
    func configure() {
        view.backgroundColor = .systemBackground
        view.addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(40)
        }
        
        stackView.axis = .vertical
        stackView.alignment = .fill
        
        [firstTextField, secondTextField, thirdTextField].forEach {
            $0.borderStyle = .roundedRect
            $0.snp.makeConstraints { make in
                make.height.equalTo(50)
            }
        }
        
        [firstTextField, secondTextField, thirdTextField, resultLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        firstTextField.becomeFirstResponder()
    }
    
    
}
