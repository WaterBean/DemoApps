//
//  CityTableViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/6/25.
//

import UIKit
import Kingfisher

final class CityInfoTableViewCell: UITableViewCell {
    
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    @IBOutlet private var backgroundImageView: UIImageView!
    @IBOutlet private var cityCellBackgroundView: UIView!
    @IBOutlet private var shadowView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cityNameLabel.font = .boldSystemFont(ofSize: 24)
        cityNameLabel.textAlignment = .right
        cityNameLabel.textColor = .white
        
        explainLabel.textAlignment = .left
        explainLabel.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.5)
        explainLabel.textColor = .white
        
        backgroundImageView.contentMode = .scaleAspectFill
        cityCellBackgroundView.clipsToBounds = true
        cityCellBackgroundView.layer.cornerRadius = 16
        cityCellBackgroundView.layer.maskedCorners = CACornerMask(arrayLiteral: .layerMinXMinYCorner, .layerMaxXMaxYCorner)
        
        
        shadowView.layer.shadowColor = UIColor.black.cgColor
        shadowView.layer.shadowOpacity = 0.8
        shadowView.layer.shadowRadius = 12
        shadowView.layer.shadowOffset = CGSize(width: 2, height: 4)
        shadowView.layer.shadowPath = nil
        
    }

    
    func configureCell(row: City, keyword: String) {
        cityNameLabel.text = "\(row.city_name) | \(row.city_english_name)"
        explainLabel.text = "  " + row.city_explain
        let url = URL(string: row.city_image)
        backgroundImageView.kf.setImage(with: url, placeholder: UIImage(named: "photo"))
        cityNameLabel.attributedText = cityNameLabel.text?.toAttribute(keyword)
        explainLabel.attributedText = explainLabel.text?.toAttribute(keyword)
        if keyword.contains(where: { $0.isUppercase }) {
            cityNameLabel.attributedText = cityNameLabel.text?.toAttribute(keyword.capitalized)
            explainLabel.attributedText = explainLabel.text?.toAttribute(keyword.capitalized)
        }

    }
    
    
}
