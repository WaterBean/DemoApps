//
//  WishListViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 2/26/25.
//

import UIKit
import SnapKit
import RxCocoa
import RxSwift

final class WishListViewController: UIViewController {
    
    private var wishList: [Wish] = []
    private let repository: WishRepository
    private let folderId: UUID
    
    private var diffableDatasource: UICollectionViewDiffableDataSource<Section, Wish>!
    private let disposeBag = DisposeBag()
    
    init(repository: WishRepository, folderId: UUID) {
        self.repository = repository
        self.folderId = folderId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDatasource()
        loadWishes()
        bind()
    }
    
    func loadWishes() {
        wishList = repository.getWishes(folderId: folderId)
        updateSnapShot()
    }
    
    func bind() {
        textField.rx.controlEvent(.editingDidEndOnExit)
            .withLatestFrom(textField.rx.text.orEmpty)
            .debug()
            .bind(with: self) { owner, value in
                let wish = Wish(id: UUID(), name: value, price: Int.random(in: 100...10000), date: .now)
                owner.repository.addWish(name: wish.name, price: wish.price, date: wish.date, folderId: owner.folderId)
                owner.wishList.insert(wish, at: 0)
                owner.updateSnapShot()
            }
            .disposed(by:
                        disposeBag)
    }
    
    private func configureDatasource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Wish> { cell, _, itemIdentifier in
            var config = UIListContentConfiguration.subtitleCell()
            config.text = itemIdentifier.name
            config.secondaryText = itemIdentifier.date.formatted(date: .abbreviated, time: .shortened)
            
            var backgroundConfig = UIBackgroundConfiguration.listAccompaniedSidebarCell()
            backgroundConfig.backgroundColor = .systemGreen
            cell.contentConfiguration = config
            cell.backgroundConfiguration = backgroundConfig
        }
        
        diffableDatasource = UICollectionViewDiffableDataSource(
            collectionView: collectionView,
            cellProvider: { collectionView, indexPath, itemIdentifier in
                let cell = collectionView.dequeueConfiguredReusableCell(using: registration, for: indexPath, item: itemIdentifier)
                return cell
            }
        )
    }
    
    private func updateSnapShot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Wish>()
        snapshot.appendSections(Section.allCases)
        snapshot.appendItems(wishList, toSection: .wish)
        diffableDatasource.apply(snapshot, animatingDifferences: true)
    }
    
    enum Section: CaseIterable {
        case wish
    }

    private let textField = {
        let textField = UITextField()
        textField.backgroundColor = .systemFill
        textField.placeholder = "위시리스트를 작성해주세요"
        return textField
    }()
    
    private lazy var collectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: createLayout())
        view.delegate = self
        return view
    }()
    
    private func createLayout() -> UICollectionViewLayout {
        var config = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        config.showsSeparators = true
        config.backgroundColor = .systemBackground
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }

    private func configureUI() {
        view.backgroundColor = .systemBackground
        [collectionView, textField].forEach {
            view.addSubview($0)
        }
        textField.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(16)
            $0.height.equalTo(50)
        }
        collectionView.snp.makeConstraints {
            $0.top.equalTo(textField.snp.bottom)
            $0.bottom.horizontalEdges.equalTo(view.safeAreaLayoutGuide)
        }
        navigationItem.title = "\(repository.getFolder(id: folderId).name) 카테고리"
    }

    
}



extension WishListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        wishList.remove(at: indexPath.item)
        updateSnapShot()
    }
    
    
}
