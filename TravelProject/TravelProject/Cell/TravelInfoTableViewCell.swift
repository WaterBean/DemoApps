//
//  TravelInfoTableViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/3/25.
//

import UIKit
import Cosmos

final class TravelInfoTableViewCell: UITableViewCell {

    static let identifier = "TravelInfoTableViewCell"
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var subTitleLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var travelInfoImageView: UIImageView!
    @IBOutlet var likeButton: UIButton!
    @IBOutlet var starView: CosmosView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
