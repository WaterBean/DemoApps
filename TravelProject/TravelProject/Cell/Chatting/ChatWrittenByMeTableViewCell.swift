//
//  ChatWrittenByMeTableViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/10/25.
//

import UIKit

final class ChatWrittenByMeTableViewCell: UITableViewCell {

    @IBOutlet var contentLabel: ChatLabel!
    @IBOutlet var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
        contentLabel.layer.backgroundColor = UIColor.systemGray5.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(row chat: Chat) {
        
        contentLabel.text = chat.message
        contentLabel.textAlignment = .right

        dateLabel.text = DateFormatterManager.formatChatDate(chat.date)
    }
    
}
