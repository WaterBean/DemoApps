//
//  ShoppingListViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit
import SnapKit

final class ShoppingListViewController: UIViewController {
    
    var item: ItemResponse? {
        didSet {
            collectionView.reloadData()
        }
    }
    lazy var buttons = [simButton, dateButton, ascButton, dscButton]
    
    private let totalNumberLabel = {
        let label = UILabel()
        label.textColor = .green
        label.font = .systemFont(ofSize: 12, weight: .bold)
        return label
    }()
    
    private let stackView = {
        let stack = UIStackView()
        stack.distribution = .fillProportionally
        stack.alignment = .leading
        stack.axis = .horizontal
        stack.spacing = 6
        
        return stack
    }()
    
    lazy var simButton = {
        let button = FilterButton()
        var config = button.configuration
        config?.title = "정확도"
        button.configuration = config
        button.isSelected = true
        return button
    }()
    
    lazy var dateButton = {
        let button = FilterButton()
        var config = button.configuration
        config?.title = "날짜순"
        button.configuration = config
        return button
    }()
    
    lazy var ascButton = {
        let button = FilterButton()
        var config = button.configuration
        config?.title = "가격높은순"
        button.configuration = config
        return button
    }()
    
    lazy var dscButton = {
        let button = FilterButton()
        var config = button.configuration
        config?.title = "가격낮은순"
        button.configuration = config
        return button
    }()
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        layout.itemSize = CGSize(width: (UIScreen.main.bounds.width-48)/2, height: 220)
        
        return layout
    }())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }

    
}


extension ShoppingListViewController: Presentable {
    func configureHierarchy() {
        view.addSubview(totalNumberLabel)
        view.addSubview(stackView)
        stackView.addArrangedSubview(simButton)
        stackView.addArrangedSubview(dateButton)
        stackView.addArrangedSubview(dscButton)
        stackView.addArrangedSubview(ascButton)
        view.addSubview(collectionView)
    }
    
    func configureLayout() {
        totalNumberLabel.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        stackView.snp.makeConstraints{
            $0.top.equalTo(totalNumberLabel.snp.bottom).offset(20)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(stackView.snp.bottom)
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ItemCollectionViewCell.self, forCellWithReuseIdentifier: "ItemCollectionViewCell")
        collectionView.backgroundColor = .clear
        
        
        ascButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        dscButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        simButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        dateButton.addTarget(self, action: #selector(filterButtonTapped(_:)), for: .touchUpInside)
        
        guard let total = item?.total.formatted(.number) else { return }
        totalNumberLabel.text = "\(total) 개의 검색 결과"
        
    }
    
    
    
    
    @objc func filterButtonTapped(_ sender: FilterButton) {
        buttons.forEach {
            $0.isSelected = false
        }
        sender.isSelected = true
        
        
        switch sender.titleLabel?.text {
        case "정확도": NetworkManager.shared.fetchNaverShopping(query: navigationItem.title ?? "", sort: "sim") { self.item = $0 }
        case "날짜순": NetworkManager.shared.fetchNaverShopping(query: navigationItem.title ?? "", sort: "date") { self.item = $0 }
        case "가격높은순": NetworkManager.shared.fetchNaverShopping(query: navigationItem.title ?? "", sort: "dsc") { self.item = $0 }
        case "가격낮은순": NetworkManager.shared.fetchNaverShopping(query: navigationItem.title ?? "", sort: "asc") { self.item = $0 }
        default: NetworkManager.shared.fetchNaverShopping(query: navigationItem.title ?? "", sort: "sim") { self.item = $0 }
        }
    }
    
    
}

final class FilterButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configuration = UIButton.Configuration.bordered()
        configurationUpdateHandler = configHandler(_:)
        layer.cornerRadius = 8
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
    }
    
    func configHandler(_ button: UIButton)-> Void {
        switch button.state {
        case .selected:
            button.configuration?.background.backgroundColor = .white
            button.configuration?.baseForegroundColor = .black
        case .normal:
            button.configuration?.background.backgroundColor = .black
            button.configuration?.baseForegroundColor = .white
        default : break
        }

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}




extension ShoppingListViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        item?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = item?.items[indexPath.item],
              let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ItemCollectionViewCell", for: indexPath) as? ItemCollectionViewCell,
              let price = Int(item.lprice)
        else { return ItemCollectionViewCell() }
        
        
        cell.configureCell(title: item.title, imageURL: URL(string: item.image), mallName: item.mallName, price: price)
        return cell
    }
    
    
}

extension String {
    var htmlEscaped: String {
        return self.replacingOccurrences(of: "<[^>]+>&quot;", with: "", options: .regularExpression)
    }
    
}
