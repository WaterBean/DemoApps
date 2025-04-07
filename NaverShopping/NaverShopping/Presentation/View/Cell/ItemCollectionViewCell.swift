//
//  ItemCollectionViewCell.swift
//  NaverShopping
//
//  Created by 한수빈 on 1/15/25.
//

import UIKit
import Kingfisher
import RealmSwift
import RxSwift
import SnapKit
import Toast

final class ItemCollectionViewCell: UICollectionViewCell {
    
    private let titleLabel = {
        let label = UILabel()
        label.textColor = UIColor(white: 0.8, alpha: 1)
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.numberOfLines = 2
        return label
    }()
    
    private let itemImage = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    private let mallNameLabel = {
        let label = UILabel()
        label.textColor = .systemGray2
        label.font = .systemFont(ofSize: 10, weight: .regular)
        return label
    }()
    
    private let priceLabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 14, weight: .bold)
        return label
    }()
    
    private let likeButton = LikeButton(id: "")
    private var disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()
    }
    
    func configureCell(item: Item) {
        titleLabel.text = item.title.htmlEscaped
        itemImage.kf.setImage(with: URL(string: item.image))
        itemImage.layer.cornerRadius = 12
        mallNameLabel.text = item.mallName
        priceLabel.text = (Int(item.lprice) ?? 0).formatted(.number)
        likeButton.id = item.productId
        likeButton.rx.tap
            .bind(with: self) { owner, _ in
                let realm = try! Realm()
                let data = ItemData(item: item)

                if owner.likeButton.isSelected {
                    do {
                        try realm.write {
                            realm.add(data)
                            owner.superview?.makeToast("저장 완료")
                        }
                    } catch {
                        owner.superview?.makeToast("저장 실패")
                    }
                } else {
                    do {
                        let deleteItem = realm.objects(ItemData.self)
                            .filter { $0.id == item.productId }
                        try realm.write {
                            realm.delete(deleteItem)
                            owner.superview?.makeToast("취소 완료")
                        }
                    } catch {
                        owner.superview?.makeToast("삭제 실패")
                    }
                }
            }
            .disposed(by: disposeBag)
    }
}


extension ItemCollectionViewCell: Presentable {
    func configureHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(itemImage)
        contentView.addSubview(mallNameLabel)
        contentView.addSubview(priceLabel)
        contentView.addSubview(likeButton)
    }
    
    func configureLayout() {
        itemImage.snp.makeConstraints {
            $0.top.horizontalEdges.equalTo(contentView.safeAreaLayoutGuide)
            $0.height.equalTo(140)
        }
        
        mallNameLabel.snp.makeConstraints {
            $0.top.equalTo(itemImage.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(itemImage)
        }
        
        titleLabel.snp.makeConstraints{
            $0.top.equalTo(mallNameLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(itemImage)
        }
        
        priceLabel.snp.makeConstraints{
            $0.top.equalTo(titleLabel.snp.bottom).offset(6)
            $0.horizontalEdges.equalTo(itemImage)
        }
        
        likeButton.snp.makeConstraints {
            $0.bottom.equalTo(itemImage.snp.bottom).offset(-12)
            $0.trailing.equalTo(itemImage.snp.trailing)
                .inset(12)
        }
        
    }
    
    func configureView() {
        
    }
    
    
}
