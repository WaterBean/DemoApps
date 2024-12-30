//
//  ViewController.swift
//  NewWordSearcher
//
//  Created by 한수빈 on 12/29/24.
//

import UIKit

final class ViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var contentLabel: UILabel!
    @IBOutlet var searchButton: UIButton!
    @IBOutlet var searchTextField: UITextField!
    @IBOutlet var searchSuggestions: [UIButton]!
    
    private let words = ["삼귀자": "연애를 시작하기 전 썸 단계!", "만반잘부": "만나서 반갑고 잘 부탁해!", "버카충": "버스 카드 충전ㅋ", "처돌이": "처갓집의 마스코트", "jmt": "Jon Mat Tang, 정말 맛있다는 뜻"]
    
    private func configureContentLabel() {
        contentLabel.text = "단어를 터치하거나, 검색어를 입력해보세요."
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 5
    }
    
    private func configureSearchTextField() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: searchTextField.frame.height))
        searchTextField.leftView = paddingView
        searchTextField.leftViewMode = .always
        searchTextField.placeholder = #""삼귀자"같이 모르는 신조어를 검색해보세요"#
        searchTextField.enablesReturnKeyAutomatically = true
        searchTextField.borderStyle = .line
        searchTextField.layer.borderWidth = 1
        searchTextField.layer.borderColor = UIColor.black.cgColor
        searchTextField.frame.size.height = 44
        searchTextField.autocorrectionType = .no
        searchTextField.returnKeyType = .search
    }
    
    private func configureSearchSuggestions() {
        words.enumerated().forEach { index, word in
            if index < searchSuggestions.count {
                searchSuggestions[index].setTitle(word.key, for: .normal)
                searchSuggestions[index].setTitleColor(.black, for: .normal)
                searchSuggestions[index].titleLabel?.font = UIFont.systemFont(ofSize: 13)
                searchSuggestions[index].titleLabel?.numberOfLines = 0
                searchSuggestions[index].titleLabel?.lineBreakMode = .byWordWrapping
                searchSuggestions[index].clipsToBounds = true
                searchSuggestions[index].layer.cornerRadius = 12
                searchSuggestions[index].layer.borderWidth = 1
                searchSuggestions[index].layer.borderColor = UIColor.black.cgColor
//                searchSuggestions[index].sizeToFit()
                
            }
        }
    }
    
    private func configureSearchButton() {
        searchButton.tintColor = .white
        searchButton.backgroundColor = .black
        searchButton.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        searchButton.setTitle("", for: .normal)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.image = .background
        
        configureContentLabel()
        configureSearchTextField()
        configureSearchSuggestions()
        configureSearchButton()
    }
    
    private func performSearch(with text: String?) {
        contentLabel.text = searchNewWord(with: text?.lowercased())
        view.endEditing(true)
    }
    
    private func searchNewWord(with keyword: String?) -> String {
        guard let keyword else { return "무언가 잘못되었네요." }
        return words[keyword] ?? "검색결과가 없습니다."
    }
    
    @IBAction private func searchButtonTapped(_ sender: UIButton) {
        performSearch(with: searchTextField.text)
    }
    
    @IBAction private func wordButtonTapped(_ sender: UIButton) {
        searchTextField.text = sender.currentTitle
        performSearch(with: sender.currentTitle)
    }
    
    @IBAction private func hideKeyboardAction(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @IBAction private func searchAction(_ sender: UITextField) {
        performSearch(with: sender.text)
    }
    
}

