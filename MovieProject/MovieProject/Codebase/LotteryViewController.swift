//
//  LotteryViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 1/14/25.
//

import UIKit
import SnapKit

final class LotteryViewController: UIViewController {
    
    private let recentDay = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let startDate = formatter.date(from: "2002-12-07")!
        let currentDate = Date()
        let components = Calendar.current.dateComponents([.day], from: startDate, to: currentDate)
        let totalDays = components.day!
        let roundNumber = Int(ceil(Double(totalDays) / 7.0))
        return roundNumber
    }()

    private lazy var selectDrawNo = Array(1...recentDay)
    private var list = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    private lazy var textField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.textAlignment = .center
        textField.inputView = pickerView
        return textField
    }()
    
    private let descriptionLabel = {
        let label = UILabel()
        label.text = "당첨번호 안내"
        label.textColor = .black
        label.font = .systemFont(ofSize: 16, weight: .regular)
        return label
    }()
    
    private let dateLabel = {
        let label = UILabel()
        label.text = ""
        label.textColor = .gray
        label.font = .systemFont(ofSize: 12, weight: .regular)
        return label
    }()
    
    private let pickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private let resultLabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.attributedText = "913회 당첨결과".toAttribute("913회")
        return label
    }()
    
    private let stackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.spacing = 6
        
        return stackView
    }()
    
    private let lotteryNumberLabels = {
        var labels = [UILabel]()
        for _ in 0...7 {
            let label = UILabel()
            label.textAlignment = .center
            label.backgroundColor = .gray
            label.textColor = .white
            label.numberOfLines = 1
            label.clipsToBounds = true
            label.text = "00"
            label.font = .systemFont(ofSize: 16, weight: .semibold)
            labels.append(label)
            label.layer.cornerRadius = 22
            
        }
        return labels
    }()
    
    private let lineView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-32, height: 20)
        
        return view
    }()
    
    private let bonusLabel = {
        let label = UILabel()
        label.text = "보너스"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()
    
}

// MARK: - configure ui
extension LotteryViewController {
    
    private func configureHierarchy() {
        [textField, descriptionLabel, lineView, dateLabel, resultLabel, stackView, bonusLabel].forEach {
            view.addSubview($0)
        }
        
        lotteryNumberLabels.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    private func configureLayout() {
        textField.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(12)
            $0.leading.equalTo(textField.snp.leading)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom).offset(12)
            $0.trailing.equalTo(textField.snp.trailing)
        }
        
        lineView.snp.makeConstraints {
            $0.top.equalTo(descriptionLabel.snp.bottom).offset(20)
            $0.height.equalTo(1)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        resultLabel.snp.makeConstraints {
            $0.top.equalTo(lineView.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
        }
        
        stackView.snp.makeConstraints {
            $0.top.equalTo(resultLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalToSuperview().inset(6)
            $0.height.equalTo(44)
        }
        
        bonusLabel.snp.makeConstraints {
            $0.top.equalTo(lotteryNumberLabels[7].snp.bottom).offset(4)
            $0.centerX.equalTo(lotteryNumberLabels[7].snp.centerX)
        }
    }
    
    private func configureView() {
        lotteryNumberLabels[6].text = "+"
        lotteryNumberLabels[6].backgroundColor = .white
        lotteryNumberLabels[6].textColor = .black
        
        //        pickerView.delegate = self
        //        pickerView.selectRow(recentDay-1, inComponent: 0, animated: true)
        
        
        textField.text = "\(recentDay)"
        NetworkManager.shared.fetchLotteryRequest(drawNumber:  recentDay) { [unowned self] in
            self.resultLabel.attributedText = "\($0.drwNo)회 당첨결과".toAttribute("\($0.drwNo)회")
            
            self.dateLabel.text = "\($0.drwNoDate) 추첨"
            self.lotteryNumberLabels[0].text = "\($0.drwtNo1)"
            self.lotteryNumberLabels[1].text = String($0.drwtNo2)
            self.lotteryNumberLabels[2].text = String($0.drwtNo3)
            self.lotteryNumberLabels[3].text = String($0.drwtNo4)
            self.lotteryNumberLabels[4].text = String($0.drwtNo5)
            self.lotteryNumberLabels[5].text = String($0.drwtNo6)
            self.lotteryNumberLabels[7].text = String($0.bnusNo)
            
            self.lotteryNumberLabels.forEach {
                guard let num = Int($0.text ?? "") else { return }
                $0.backgroundColor = lotteryColor(number: num)
            }
        }
    }
    
    private func lotteryColor(number: Int) -> UIColor {
        switch number {
        case 1...10: .systemYellow
        case 11...20: .systemBlue
        case 21...30: .systemRed
        case 31...40: .systemGray
        case 41...45: .systemGreen
        default: .white
        }
    }

    
}



extension LotteryViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        selectDrawNo.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textField.text = String(selectDrawNo[row])
        NetworkManager.shared.fetchLotteryRequest(drawNumber:  selectDrawNo[row]) { [self] in
            self.resultLabel.attributedText = "\($0.drwNo)회 당첨결과".toAttribute("\($0.drwNo)회")

            self.dateLabel.text = "\($0.drwNoDate) 추첨"
            self.lotteryNumberLabels[0].text = "\($0.drwtNo1)"
            self.lotteryNumberLabels[1].text = String($0.drwtNo2)
            self.lotteryNumberLabels[2].text = String($0.drwtNo3)
            self.lotteryNumberLabels[3].text = String($0.drwtNo4)
            self.lotteryNumberLabels[4].text = String($0.drwtNo5)
            self.lotteryNumberLabels[5].text = String($0.drwtNo6)
            self.lotteryNumberLabels[7].text = String($0.bnusNo)
            
            self.lotteryNumberLabels.forEach {
                guard let num = Int($0.text ?? "") else { return }
                $0.backgroundColor = lotteryColor(number: num)
            }
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(selectDrawNo[row])
    }
    
    
}


