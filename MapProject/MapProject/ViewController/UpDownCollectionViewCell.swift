//
//  UpDownCollectionViewCell.swift
//  MapProject
//
//  Created by 한수빈 on 1/9/25.
//

import UIKit

final class UpDownCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var numberBackgroundView: UIView!
    @IBOutlet var numberLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberBackgroundView.backgroundColor = .white
        numberBackgroundView.clipsToBounds = true
        numberLabel.textAlignment = .center
        DispatchQueue.main.async {
            self.numberBackgroundView.layer.cornerRadius = self.frame.width / 2
        }
    }
    func configureCell(isSelected: Bool) {
        
        numberBackgroundView.backgroundColor = isSelected ? .black : .white
        numberLabel.textColor = isSelected ? .white : .black
        
    }
    
}
