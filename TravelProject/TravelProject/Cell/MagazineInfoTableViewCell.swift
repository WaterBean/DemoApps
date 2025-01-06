//
//  MagazineInfoTableViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/3/25.
//

import UIKit
import Kingfisher

final class MagazineInfoTableViewCell: UITableViewCell {
    
    static let identifier = "MagazineInfoTableViewCell"
    @IBOutlet var magazineImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        DispatchQueue.main.async {
            self.setupUI()
        }
    }

    private func setupUI() {
        magazineImageView.contentMode = .scaleAspectFill
        magazineImageView.clipsToBounds = true
        magazineImageView.layer.cornerRadius = 16

        titleLabel.numberOfLines = 2
        titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        
        subTitleLabel.textColor = .systemGray2
        subTitleLabel.font = .systemFont(ofSize: 14, weight: .semibold)

        dateLabel.textAlignment = .right
        dateLabel.textColor = .systemGray2
        dateLabel.font = .systemFont(ofSize: 12, weight: .medium)

    }
    
    func configureCell(_ row: Magazine) {
        
        if let url = URL(string: row.photo_image) {
            magazineImageView.kf.setImage(with: url ,placeholder: UIImage(systemName: "sun"))
        } else {
            magazineImageView.image = UIImage(systemName: "image")
        }
        
        titleLabel.text = row.title
        subTitleLabel.text = row.subtitle

        let dateString = DateFormatterManager.formatMagazineDate(row.date)
        dateLabel.text = dateString

    }
}
