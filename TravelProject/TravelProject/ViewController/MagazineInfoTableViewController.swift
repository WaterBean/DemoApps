//
//  MagazineInfoTableViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/3/25.
//

import UIKit

final class MagazineInfoTableViewController: UITableViewController {
    
    private var magazine = MagazineInfo().magazine
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    private func setupUI() {
        navigationItem.title = "SeSAC TRAVEL"
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
    }
    
}

// MARK: - TableViewController Method
extension MagazineInfoTableViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return magazine.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: MagazineInfoTableViewCell.identifier) as! MagazineInfoTableViewCell
        let row = magazine[indexPath.row]
        
        cell.configureCell(row)
        
        return cell
    }
}
