//
//  CityInfoCollectionViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/7/25.
//

import UIKit
import Kingfisher

final class CityInfoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "CityInfoCollectionViewCell"
    
    @IBOutlet private var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityNameLabel.font = .boldSystemFont(ofSize: 16)
        cityNameLabel.textAlignment = .center
        cityNameLabel.textColor = .black
        
        explainLabel.font = .systemFont(ofSize: 12)
        explainLabel.textAlignment = .center
        explainLabel.textColor = .systemGray2
        explainLabel.numberOfLines = 0
        
        cityImageView.contentMode = .scaleAspectFill
        cityImageView.clipsToBounds = true
    }
    
    func configureCell(row: City, keyword: String) {
        cityNameLabel.text = "\(row.city_name) | \(row.city_english_name)"
        explainLabel.text = "  " + row.city_explain
        
        cityNameLabel.attributedText = cityNameLabel.text?.toAttribute(keyword)
        cityNameLabel.attributedText = cityNameLabel.text?.toAttribute(keyword.capitalized)
        explainLabel.attributedText = explainLabel.text?.toAttribute(keyword)
        explainLabel.attributedText = explainLabel.text?.toAttribute(keyword.capitalized)
        
        
        
        let placeholderImage = UIImage(systemName: "photo.artframe.circle")?
            .withRenderingMode(.alwaysTemplate)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: self.frame.width))
        
        let url = URL(string: row.city_image)
        cityImageView.kf.setImage(with: url, placeholder: placeholderImage)
        cityImageView.layer.cornerRadius = self.frame.width / 2
        
    }
    
}
