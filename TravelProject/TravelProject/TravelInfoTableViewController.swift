//
//  TravelInfoTableViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/3/25.
//

import UIKit
import Kingfisher

class TravelInfoTableViewController: UITableViewController {
    
    var travelInfo = TravelInfo().travel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 150
        
        navigationItem.title = "도시 상세 정보"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = travelInfo[indexPath.row]
        
        guard let description = row.description,
              let save = row.save,
              let image = row.travel_image,
              let grade = row.grade
        else {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "AdTableViewCell") as! AdTableViewCell
                
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TravelInfoTableViewCell") as! TravelInfoTableViewCell
        
        
        cell.titleLabel.text = row.title
        cell.titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        
        cell.subTitleLabel.text = description
        cell.subTitleLabel.textColor = .systemGray
        cell.subTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        cell.subTitleLabel.numberOfLines = 2
        
                
        cell.infoLabel.text = " · 저장 \(save.formatted(.number))"
        cell.infoLabel.textColor = .systemGray3
        cell.infoLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        let url = URL(string: image)
        cell.travelInfoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person"))
        cell.travelInfoImageView.contentMode = .scaleAspectFill
        cell.travelInfoImageView.clipsToBounds = true
        cell.travelInfoImageView.layer.cornerRadius = 12
        
        
        let likeimage = row.like ?? false ? UIImage(systemName: "heart.fill") : UIImage(systemName: "heart")
        cell.likeButton.setImage(likeimage, for: .normal)
        
        return cell
    }
    
}
