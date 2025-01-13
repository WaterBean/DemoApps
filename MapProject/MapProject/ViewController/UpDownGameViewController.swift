//
//  UpDownGameViewController.swift
//  MapProject
//
//  Created by 한수빈 on 1/9/25.
//

import UIKit

final class UpDownGameViewController: UIViewController, ViewControllerRequirement, ReusableViewProtocol, UpDownGameProtocol {
    
    static var identifier: String {
        return String(describing: self)
    }
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tryCountLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var resultButton: UIButton!
    
    var userInputMaxNumber: Int?
    var tryCount = 0
    var selectNumber = 0 {
        didSet {
            if selectNumber == 0 {
                resultButtonConfigure(text: "결과 확인하기", backgroundColor: .darkGray, action: #selector(resultButtonTapped))
            }
        }
    }
    
    
    lazy var correctAnswer: Int = 0
    
    var list: [Int] = [] {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUIWhenViewDidLoad()
        list = generateGameList(in: userInputMaxNumber ?? 100)
        
        let nib = UINib(nibName: UpDownCollectionViewCell.identifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: UpDownCollectionViewCell.identifier)
        
    }
    
    
    func generateGameList(in maxNumber: Int) -> [Int] {
        let list = Array(1...maxNumber)
        tryCount = 0
        correctAnswer = list.randomElement()!
        
        return list
    }
    
    func configureView() {
        titleLabel.text = "UP DOWN"
        titleLabel.font = .monospacedSystemFont(ofSize: 48, weight: .bold)
        titleLabel.textAlignment = .center
        
        tryCountLabel.text = "count: 0"
        tryCountLabel.font = .systemFont(ofSize: 16)
        tryCountLabel.textAlignment = .center
        
        resultButtonConfigure(text: "결과 확인하기", backgroundColor: .darkGray, action: #selector(resultButtonTapped))
        
        let backgroundColor = UIColor(red: 0.3, green: 0.3, blue: 1.0, alpha: 1)
        view.backgroundColor = backgroundColor
        
        let layout = UICollectionViewFlowLayout()
        let inset: CGFloat = 16
        let itemSpacing: CGFloat = 16
        let width = UIScreen.main.bounds.width - (inset * 2) - (itemSpacing * 5)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.itemSize = CGSize(width: width/6, height: width/6)
        collectionView.collectionViewLayout = layout
        collectionView.backgroundColor = backgroundColor
    }
    
    func selectNumberIsCorrect(select number: Int) -> ResultCase {
        switch number {
        case 1..<correctAnswer: ResultCase.up
        case correctAnswer: ResultCase.correct
        default: ResultCase.down
        }
    }
    
    func whenUserSelectDown() {
        print(#function)
        list = Array(list.filter({ $0 < selectNumber}))
        titleLabel.text = "DOWN"
        selectNumber = 0
    }
    
    func whenUserSelectUp() {
        print(#function)
        list = Array(list.filter { $0 > selectNumber })
        titleLabel.text = "UP"
        selectNumber = 0
    }
    
    func whenUserSelectCorrectAnswer() {
        print(#function)
        titleLabel.text = "GOOD!"
        resultButtonConfigure(text: "다시 하기", backgroundColor: .black, action: #selector(gameEnd))
    }
    
    fileprivate func resultButtonConfigure(text: String, backgroundColor: UIColor, action: Selector) {
        let attributedString = NSAttributedString(string: text, attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.white] )
        resultButton.setAttributedTitle(attributedString, for: .normal)
        resultButton.backgroundColor = backgroundColor
        resultButton.addTarget(self, action: action, for: .touchUpInside)
    }
    
    @objc func gameEnd() {
        dismiss(animated: true)
    }
    
    @objc func resultButtonTapped() {
        if selectNumber == 0 { return }
        tryCount += 1
        let result = selectNumberIsCorrect(select: selectNumber)
        switch result {
        case .up: whenUserSelectUp()
        case .down: whenUserSelectDown()
        case .correct: whenUserSelectCorrectAnswer()
        }
        tryCountLabel.text = "시도 횟수: \(tryCount)"
    }
    
    func setupDelegateAndDatasource() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
}



extension UpDownGameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpDownCollectionViewCell.identifier, for: indexPath) as! UpDownCollectionViewCell
        cell.numberBackgroundView.backgroundColor = list[indexPath.item] == selectNumber ? .black : .white
        cell.numberLabel.textColor = list[indexPath.item] == selectNumber ? .white : .black

        cell.numberLabel.text = "\(list[indexPath.item])"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(#function)
        if selectNumber == list[indexPath.item] {
            selectNumber = 0
        } else {
            resultButtonConfigure(text: "결과 확인하기", backgroundColor: .black, action: #selector(resultButtonTapped))
            selectNumber = list[indexPath.item]
        }
        collectionView.reloadData()
    }
    
}
