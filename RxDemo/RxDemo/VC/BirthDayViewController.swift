//
//  BirthDayViewController.swift
//  RxDemo
//
//  Created by 한수빈 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class BirthdayViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let formatter = DateFormatter()
    let pickedDate = PublishSubject<Date>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Color.white
        configureLayout()
        bind()
        pickedDate.onNext(Date.now)
    }
    
    func bind() {
        birthDayPicker.rx.date
            .bind(with: self) { owner, date in
                owner.pickedDate.onNext(date)
            }
            .disposed(by: disposeBag)
        
        pickedDate
            .withUnretained(self)
            .map { owner, date -> (Bool, String, String, String) in
                let ageValid = date <= Calendar.current.date(byAdding: .year, value: -17, to: .now)! ? true : false
                owner.formatter.dateFormat = "yyyy년"
                let year: String = owner.formatter.string(from: date)
                owner.formatter.dateFormat = "M월"
                let month = owner.formatter.string(from: date)
                owner.formatter.dateFormat = "d일"
                let day = owner.formatter.string(from: date)
                return (ageValid, year, month, day)
            }
            .bind(with: self) { owner, value in
                owner.yearLabel.text = value.1
                owner.monthLabel.text = value.2
                owner.dayLabel.text = value.3
                owner.nextButton.isEnabled = value.0
            }
            .disposed(by: disposeBag)
        
        nextButton.rx.tap.bind(with: self) { owner, _ in
            Alert.simpleAlert(owner: owner, "가입 성공")
        }
        .disposed(by: disposeBag)
    }
    
    func configureLayout() {
        view.addSubview(infoLabel)
        view.addSubview(containerStackView)
        view.addSubview(birthDayPicker)
        view.addSubview(nextButton)
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(150)
            $0.centerX.equalToSuperview()
        }
        
        containerStackView.snp.makeConstraints {
            $0.top.equalTo(infoLabel.snp.bottom).offset(30)
            $0.centerX.equalToSuperview()
        }
        
        [yearLabel, monthLabel, dayLabel].forEach {
            containerStackView.addArrangedSubview($0)
        }
        
        birthDayPicker.snp.makeConstraints {
            $0.top.equalTo(containerStackView.snp.bottom)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(birthDayPicker.snp.bottom).offset(30)
            make.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
        }
    }
    
    private let birthDayPicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.preferredDatePickerStyle = .wheels
        picker.locale = Locale(identifier: "ko-KR")
        picker.maximumDate = Date()
        return picker
    }()
    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textColor = Color.black
        label.text = "만 17세 이상만 가입 가능합니다."
        return label
    }()
    private let containerStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.spacing = 10
        return stack
    }()
    private let yearLabel: UILabel = {
        let label = UILabel()
        label.text = "2023년"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    private let monthLabel: UILabel = {
        let label = UILabel()
        label.text = "33월"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    private let dayLabel: UILabel = {
        let label = UILabel()
        label.text = "99일"
        label.textColor = Color.black
        label.snp.makeConstraints {
            $0.width.equalTo(100)
        }
        return label
    }()
    private let nextButton = PointButton(title: "가입하기")
    
    
}



enum Color {
    static let black: UIColor = .label
    static let white: UIColor = .systemBackground
}

final class PointButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setTitle(title, for: .normal)
        setTitleColor(Color.white, for: .normal)
        setTitleColor(.red, for: .disabled)
        backgroundColor = Color.black
        layer.cornerRadius = 10
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
