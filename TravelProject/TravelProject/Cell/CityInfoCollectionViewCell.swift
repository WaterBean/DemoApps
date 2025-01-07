//
//  CityInfoCollectionViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/7/25.
//

import UIKit

final class CityInfoCollectionViewCell: UICollectionViewCell {

    static let identifier = "CityInfoCollectionViewCell"
    
    @IBOutlet var cityImageView: UIImageView!
    @IBOutlet var cityNameLabel: UILabel!
    @IBOutlet var explainLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        cityImageView.image.
    }

}
