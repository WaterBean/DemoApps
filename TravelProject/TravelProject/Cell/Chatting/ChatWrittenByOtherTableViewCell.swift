//
//  ChatWrittenByOtherTableViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/10/25.
//

import UIKit

final class ChatWrittenByOtherTableViewCell: UITableViewCell {

    @IBOutlet private var profileImageView: UIImageView!
    @IBOutlet private var nameLabel: UILabel!
    @IBOutlet private var contentLabel: ChatLabel!
    @IBOutlet private var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCellStyle()
    }

    private func configureCellStyle() {
        selectionStyle = .none
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.clipsToBounds = true
        DispatchQueue.main.async { [unowned self] in
            profileImageView.layer.cornerRadius = profileImageView.frame.width / 2
        }
        nameLabel.textColor = .gray        
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }
    
    
    
    func configureCell(row chat: Chat) {
        profileImageView.image = UIImage(named: chat.user.profileImage)
        nameLabel.text = chat.user.rawValue
        contentLabel.text = chat.message
        dateLabel.text = DateFormatterManager.formatChatDate(chat.date)
    }
}


