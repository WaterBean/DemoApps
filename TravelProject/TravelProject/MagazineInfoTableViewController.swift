//
//  MagazineInfoTableViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/3/25.
//

import UIKit
import Kingfisher

final class MagazineInfoTableViewController: UITableViewController {

    private var magazine = MagazineInfo().magazine
    let formatter = DateFormatter()

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.title = "SeSAC TRAVEL"
        
        tableView.rowHeight = 500
        tableView.separatorStyle = .none
        
    }
    
    
}


extension MagazineInfoTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MagazineInfoTableViewCell") as! MagazineInfoTableViewCell
        let row = magazine[indexPath.row]
        
        if let url = URL(string: row.photo_image) {
            cell.magazineImageView.kf.setImage(with: url ,placeholder: UIImage(systemName: "sun"))
        } else {
            cell.magazineImageView.image = UIImage(systemName: "image")
        }
        cell.magazineImageView.contentMode = .scaleAspectFill
        cell.magazineImageView.clipsToBounds = true
        cell.magazineImageView.layer.cornerRadius = 16
        
        cell.titleLabel.text = row.title
        cell.titleLabel.numberOfLines = 2
        cell.titleLabel.font = .systemFont(ofSize: 24, weight: .semibold)
        cell.subTitleLabel.text = row.subtitle
        cell.subTitleLabel.textColor = .systemGray2
        cell.subTitleLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        formatter.dateFormat = "yyMMdd"
        let date = formatter.date(from: row.date)
        formatter.dateFormat = "yy년 MM월 dd일"
        let dateString = formatter.string(for: date)
        
        cell.dateLabel.text = dateString
        cell.dateLabel.textAlignment = .right
        cell.dateLabel.textColor = .systemGray2
        cell.dateLabel.font = .systemFont(ofSize: 12, weight: .medium)
        
        return cell
    }
}
