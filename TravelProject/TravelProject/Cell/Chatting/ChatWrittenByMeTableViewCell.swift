//
//  ChatWrittenByMeTableViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/10/25.
//

import UIKit

final class ChatWrittenByMeTableViewCell: UITableViewCell {

    @IBOutlet private var contentLabel: ChatLabel!
    @IBOutlet private var dateLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        configureCellStyle()
    }

    private func configureCellStyle() {
        selectionStyle = .none
        contentLabel.layer.backgroundColor = UIColor.systemGray5.cgColor
        contentLabel.textAlignment = .right
        dateLabel.textColor = .lightGray
        dateLabel.font = .systemFont(ofSize: 12, weight: .regular)
    }

    
    
    
    func configureCell(row chat: Chat) {
        contentLabel.text = chat.message
        dateLabel.text = DateFormatterManager.formatChatDate(chat.date)
    }
    
}
