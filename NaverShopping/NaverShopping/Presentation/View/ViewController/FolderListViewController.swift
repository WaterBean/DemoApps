//
//  FolderListViewController.swift
//  NaverShopping
//
//  Created by 한수빈 on 3/5/25.
//

import UIKit
import SnapKit

final class FolderListViewController: UIViewController {
    
    private var folderList: [Folder] = []
    private let repository: WishRepository = RealmWishRepository()
    private var diffableDatasource: UICollectionViewDiffableDataSource<Section, Folder>!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDatasource()
        // MARK: - 최초 실행 후 주석
//        addFolder()
        updateSnapShot()
    }
    
    func addFolder() {
        repository.addFolder(name: "전자제품")
        repository.addFolder(name: "건강식품")
    }
    
    private func configureDatasource() {
        let registration = UICollectionView.CellRegistration<UICollectionViewListCell, Folder> { cell, _, itemIdentifier in
            var config = UIListContentConfiguration.subtitleCell()
            config.text = itemIdentifier.name
            config.secondaryText = "\(itemIdentifier.wishes.count)개의 항목"
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
        var snapshot = NSDiffableDataSourceSnapshot<Section, Folder>()
        snapshot.appendSections(Section.allCases)
        folderList = repository.getAllFolder()
        snapshot.appendItems(folderList, toSection: .folder)
        diffableDatasource.apply(snapshot, animatingDifferences: true)
    }
    
    private enum Section: CaseIterable {
        case folder
    }
    
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
        navigationItem.title = "위시리스트"
        [collectionView].forEach {
            view.addSubview($0)
        }
        collectionView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }

    
}

extension FolderListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selected = folderList[indexPath.item]
        let vc = WishListViewController(
            repository: repository,
            folderId: selected.id
        )
        navigationController?.pushViewController(
            vc, animated: true)
    }
    
    
}
