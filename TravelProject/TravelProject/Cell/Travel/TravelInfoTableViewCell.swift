//
//  TravelInfoTableViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/3/25.
//

import UIKit
import Cosmos
import Kingfisher


final class TravelInfoTableViewCell: UITableViewCell {

    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subTitleLabel: UILabel!
    @IBOutlet private var infoLabel: UILabel!
    @IBOutlet private var travelInfoImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet private var starView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)

        subTitleLabel.textColor = .systemGray
        subTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        subTitleLabel.numberOfLines = 0

        infoLabel.textColor = .systemGray3
        infoLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        travelInfoImageView.contentMode = .scaleAspectFill
        travelInfoImageView.clipsToBounds = true
        travelInfoImageView.layer.cornerRadius = 12

        starView.settings.updateOnTouch = false
    }
    
    func configureCell(_ row: Travel) {
        guard let description = row.description,
              let save = row.save,
              let image = row.travel_image,
              let grade = row.grade,
              let isLike = row.like
        else { return } // 하나라도 바인딩이 안된다면 전부 값을 안바꿔주는게 맞나?
        
        titleLabel.text = row.title
        subTitleLabel.text = description
        starView.rating = grade
        infoLabel.text = " · 저장 \(save.formatted(.number))"
        
        let (likeImage, color) = getlikeButtonAttribute(isLike: isLike)
        likeButton.setImage(likeImage, for: .normal)
        likeButton.tintColor = color
        
        let url = URL(string: image)
        travelInfoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo.on.rectangle"))

    }

    private func getlikeButtonAttribute(isLike: Bool) -> (UIImage?, UIColor) {
        let (likeImage, color) = isLike ? (UIImage(systemName: "heart.fill"), UIColor.systemPink) : (UIImage(systemName: "heart"), UIColor.white)

        return (likeImage, color)
    }

}
