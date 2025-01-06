//
//  TravelInfoTableViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/3/25.
//

import UIKit
import Kingfisher

final class TravelInfoTableViewController: UITableViewController {
    
    let adCellColor: [UIColor] = [.cyan,.magenta,.yellow]

    private var travelInfo = TravelInfo().travel {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"
    }
    
    @objc func likeButtonTapped (_ sender: UIButton){
        travelInfo[sender.tag].like?.toggle()
    }
}


extension TravelInfoTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if travelInfo[indexPath.row].ad == true {
            return 100
        } else {
            return 150
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = travelInfo[indexPath.row]
        
        guard let description = row.description,
              let save = row.save,
              let image = row.travel_image,
              let grade = row.grade,
              row.ad == false
        else {
            let cell  = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier) as! AdTableViewCell
            
            cell.contentLabel.text =  row.title
            cell.contentLabel.font =  .boldSystemFont(ofSize: 18)
            cell.contentLabel.numberOfLines = 0
            cell.contentLabel.textAlignment = .center
            
            cell.adLabel.backgroundColor = .white
            cell.adLabel.clipsToBounds = true
            cell.adLabel.layer.cornerRadius = 4
            
            cell.selectionStyle = .none
            cell.backgroundColor = adCellColor[indexPath.row % adCellColor.count]
            cell.separatorInset = UIEdgeInsets(top: 0, left: view.frame.width, bottom: 0, right: 0)
            cell.layer.cornerRadius = 12
            cell.clipsToBounds = true
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TravelInfoTableViewCell.identifier) as! TravelInfoTableViewCell
        
        cell.selectionStyle = .none
        
        if indexPath.row < travelInfo.count - 1 && travelInfo[indexPath.row + 1].ad == true {
            cell.separatorInset = UIEdgeInsets(top: 0, left: view.frame.width, bottom: 0, right: 0)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
        
        cell.titleLabel.text = row.title
        cell.titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        
        cell.subTitleLabel.text = description
        cell.subTitleLabel.textColor = .systemGray
        cell.subTitleLabel.font = .systemFont(ofSize: 14, weight: .medium)
        cell.subTitleLabel.numberOfLines = 2
        
        cell.starView.rating = grade
        cell.starView.settings.updateOnTouch = false
        
        cell.infoLabel.text = " · 저장 \(save.formatted(.number))"
        cell.infoLabel.textColor = .systemGray3
        cell.infoLabel.font = .systemFont(ofSize: 14, weight: .medium)
        
        let url = URL(string: image)
        cell.travelInfoImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "photo.on.rectangle"))
        cell.travelInfoImageView.contentMode = .scaleAspectFill
        cell.travelInfoImageView.clipsToBounds = true
        cell.travelInfoImageView.layer.cornerRadius = 12
        
        
        let (likeImage, color) = row.like ?? false ? (UIImage(systemName: "heart.fill"), UIColor.systemPink) : (UIImage(systemName: "heart"), UIColor.white)
        cell.likeButton.setImage(likeImage, for: .normal)
        cell.likeButton.tintColor = color
        cell.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
        cell.likeButton.tag = indexPath.row
        return cell
    }

}
