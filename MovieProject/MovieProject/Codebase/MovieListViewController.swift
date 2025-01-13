//
//  MovieListViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 1/13/25.
//

import UIKit
import SnapKit

final class MovieListViewController: UIViewController {

    let backgroundView = {
        let view = UIView()
        view.backgroundColor = .black.withAlphaComponent(0.8)
        return view
    }()
    
    let backgroundImage = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "1")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let searchTextField = {
        let textField = UITextField()
        textField.borderStyle = .none
        textField.backgroundColor = .clear
        return textField
    }()
    
    let searchButton = {
        let button = UIButton()
        button.setTitle("검색", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        
        return button
    }()
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width-32, height: 44)
        return layout
    }())
    
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .clear

        addSubView(target: self, views: [backgroundImage, backgroundView, searchTextField, searchButton, collectionView])
        
        collectionView.register(MovieListCollectionViewCell.self, forCellWithReuseIdentifier: "MovieListCollectionViewCell")
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self

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

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        let border = CALayer()
        let width = CGFloat(3)
        
        border.borderColor = UIColor.white.cgColor
        border.frame = CGRect(x: 0, y: 57, width: searchTextField.frame.width, height: width)
        border.borderWidth = width
        searchTextField.layer.addSublayer(border)
    }
    
    
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieListCollectionViewCell", for: indexPath) as? MovieListCollectionViewCell else { return MovieListCollectionViewCell() }
        
        return cell
    }
    
}

#Preview {
    MovieListViewController()
}
