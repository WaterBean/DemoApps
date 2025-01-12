//
//  TravelTalkCollectionViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/10/25.
//

import UIKit

final class TravelTalkCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var recentTalkLabel: UILabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configureCellStyle()
        
    }
    
    func configureCellStyle() {
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        DispatchQueue.main.async { [unowned self] in
            profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        }
        recentTalkLabel.font = .systemFont(ofSize: 14, weight: .regular)
        recentTalkLabel.textColor = .gray

        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
        dateLabel.textColor = .gray

    }
    
    func configureCell(_ item: ChatRoom) {
        profileImageView.image = UIImage(named: item.chatroomImage[0])
        
        nameLabel.text = item.chatroomName
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        recentTalkLabel.text = item.chatList.last?.message
        
        let date = DateFormatterManager.formatTravleTalkDate(item.chatList.last?.date ?? "")
        dateLabel.text = date
        
    }
    
}
