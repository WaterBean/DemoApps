//
//  MagazineInfoTableViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/3/25.
//

import UIKit

class MagazineInfoTableViewCell: UITableViewCell {
    
    @IBOutlet var magazineImageView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
