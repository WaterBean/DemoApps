//
//  ChatWrittenByOtherTableViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/10/25.
//

import UIKit

final class ChatWrittenByOtherTableViewCell: UITableViewCell {

    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var contentLabel: ChatLabel!
    @IBOutlet var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(row chat: Chat) {
        profileImageView.image = UIImage(named: chat.user.profileImage)
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        
        DispatchQueue.main.async { [unowned self] in
            profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        }
        
        nameLabel.text = chat.user.rawValue
        nameLabel.textColor = .gray
        
        contentLabel.text = chat.message
        
        dateLabel.text = DateFormatterManager.formatChatDate(chat.date)

    }
}


