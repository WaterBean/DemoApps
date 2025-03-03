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
    
    private var list = [
        Wish(name: "M5 Max"),
        Wish(name: "금 100k"),
        Wish(name: "ctype 트랙패드"),
        Wish(name: "누피 Kick 75"),
        Wish(name: "누피 Air 96"),
        Wish(name: "누피 Halo 96 레몬축")
    ]
    
    let disposeBag = DisposeBag()
    
    private var diffableDatasource: UICollectionViewDiffableDataSource<Section, Wish>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDatasource()
        updateSnapShot()
        bind()
    }
    
    func bind() {
        textField.rx.controlEvent(.editingDidEndOnExit)
            .withLatestFrom(textField.rx.text.orEmpty)
            .debug()
            .bind(with: self) { owner, value in
                let product = Wish(name: "\(value)")
                owner.list.insert(product, at: 0)
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
        snapshot.appendItems(list, toSection: .wish)
        diffableDatasource.apply(snapshot, animatingDifferences: true)
    }
    
    enum Section: CaseIterable {
        case wish
    }
    
    struct Wish: Hashable, Identifiable {
        let id = UUID()
        let name: String
        let price = 4000
        let date = Date()
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
    }

    
}



extension WishListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        list.remove(at: indexPath.item)
        updateSnapShot()
    }
    
    
}
