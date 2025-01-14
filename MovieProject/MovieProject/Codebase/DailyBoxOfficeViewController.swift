//
//  DailyBoxOfficeViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 1/13/25.
//

import UIKit
import SnapKit

final class DailyBoxOfficeViewController: UIViewController {

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
    
    private let searchTextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .clear
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
        view.backgroundColor = .clear
        configureHierarchy(target: self, views: [backgroundImage, backgroundView, searchTextField, searchButton, collectionView])
        
        collectionView.register(DailyBoxOfficeCollectionViewCell.self, forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        configureLayout()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        searchTextField.underlined(viewSize: searchTextField.frame.width, color: .white, underlineWidth: 3)
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
    
    
}

// MARK: - CollectionView Delegate, DataSource
extension DailyBoxOfficeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as? DailyBoxOfficeCollectionViewCell else { return DailyBoxOfficeCollectionViewCell() }
        
        return cell
    }
    
    
}

#Preview {
    DailyBoxOfficeViewController()
}
