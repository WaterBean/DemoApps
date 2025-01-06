//
//  TravelInfoTableViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/3/25.
//

import UIKit

final class TravelInfoTableViewController: UITableViewController {
    
    private var travelInfo = TravelInfo().travel {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "도시 상세 정보"
    }
    
    @objc private func likeButtonTapped (_ sender: UIButton){
        travelInfo[sender.tag].like?.toggle()
    }
}


// MARK: - TableViewController Method
extension TravelInfoTableViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if travelInfo[indexPath.row].ad == true {
            return 100
        } else {
            return UITableView.automaticDimension
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return travelInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let row = travelInfo[indexPath.row]
        
        if row.ad {
            let cell = tableView.dequeueReusableCell(withIdentifier: AdTableViewCell.identifier) as! AdTableViewCell
            cell.tag = indexPath.row
            cell.configureCell(row: row)

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: TravelInfoTableViewCell.identifier) as! TravelInfoTableViewCell
            cell.tag = indexPath.row
            cell.configureCell(row)
            configPreviousAdCellSeparatorInset(indexPath, cell)
            
            cell.likeButton.tag = indexPath.row
            cell.likeButton.addTarget(self, action: #selector(likeButtonTapped(_:)), for: .touchUpInside)
            
            return cell
        }
    }
    
    private func configPreviousAdCellSeparatorInset(_ indexPath: IndexPath, _ cell: TravelInfoTableViewCell) {
        if indexPath.row < travelInfo.count - 1 && travelInfo[indexPath.row + 1].ad == true {
            cell.separatorInset = UIEdgeInsets(top: 0, left: view.frame.width, bottom: 0, right: 0)
        } else {
            cell.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        }
    }
    
}
