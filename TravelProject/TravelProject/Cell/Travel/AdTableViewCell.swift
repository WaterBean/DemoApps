//
//  AdTableViewCell.swift
//  TravelProject
//
//  Created by 한수빈 on 1/3/25.
//

import UIKit

final class AdTableViewCell: UITableViewCell {
    
    static let identifier = "AdTableViewCell"
    @IBOutlet private var adLabel: UILabel!
    @IBOutlet private var contentLabel: UILabel!
    
    private var adCellColor: UIColor {
        let color: [UIColor] = [.cyan, .magenta, .yellow]
        return color[tag % color.count]
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    private func setupUI() {
        selectionStyle = .none
        separatorInset = UIEdgeInsets(top: 0, left: frame.width, bottom: 0, right: 0)
        layer.cornerRadius = 12
        clipsToBounds = true
        
        contentLabel.font =  .boldSystemFont(ofSize: 18)
        contentLabel.numberOfLines = 0
        contentLabel.textAlignment = .center
        
        adLabel.backgroundColor = .white
        adLabel.clipsToBounds = true
        adLabel.layer.cornerRadius = 4
    }
    
    func configureCell(row: Travel) {
        contentLabel.text = row.title
        backgroundColor = adCellColor
    }
    
}
