//
//  DailyBoxOfficeViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 1/13/25.
//

import UIKit
import SnapKit
import Alamofire

final class DailyBoxOfficeViewController: UIViewController {
    
    var list: [DailyBoxOfficeList] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    private let backgroundView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.8)
        return view
    }()
    
    private let backgroundImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // TODO: - textfield validate
    private let searchTextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let yesterDay = Calendar.current.date(byAdding: .day,value: -1, to: Date())!
        textField.text = formatter.string(from: yesterDay)
        return textField
    }()
    
    private let searchButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width-32, height: 44)
        return layout
    }())
        
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy(target: self, views: [backgroundImage, backgroundView, searchTextField, searchButton, collectionView])
        configureView()
        configureLayout()
        
        NetworkManager.shared.fetchBoxOfficeRanking(date: searchTextField.text!) {
            self.list = $0
        }
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        searchTextField.underlined(viewSize: searchTextField.frame.width, color: .white, underlineWidth: 3)
    }
    private func configureView() {
        view.backgroundColor = .clear
        collectionView.register(DailyBoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        searchButton.addTarget(self, action: #selector(searchButtonTapped), for: .touchUpInside)
    }

    private func configureLayout() {
        searchTextField.snp.makeConstraints{
            $0.top.equalTo(100)
            $0.leading.equalTo(30)
            $0.height.equalTo(60)
        }
        
        searchButton.snp.makeConstraints{
            $0.top.equalTo(searchTextField)
            $0.leading.equalTo(searchTextField.snp.trailing).offset(20)
            $0.trailing.equalTo(-20)
            $0.width.equalTo(80)
            $0.height.equalTo(60)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom)
            $0.bottom.horizontalEdges.equalToSuperview()
        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        backgroundImage.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    @objc func searchButtonTapped() {
        guard let date = searchTextField.text else {
            print("텍스트 필드 값이 유효하지 않음")
            return
        }
        NetworkManager.shared.fetchBoxOfficeRanking(date: date) {
            self.list = $0
        }
    }
    
}

// MARK: - CollectionView Delegate, DataSource
extension DailyBoxOfficeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = list[indexPath.item]
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as? DailyBoxOfficeCollectionViewCell else { return DailyBoxOfficeCollectionViewCell() }
        cell.rankLabel.text = item.rank
        cell.titleLabel.text = item.movieNm
        cell.dateLabel.text = item.openDt
        
        return cell
    }
    
    
}




#Preview {
    DailyBoxOfficeViewController()
}
