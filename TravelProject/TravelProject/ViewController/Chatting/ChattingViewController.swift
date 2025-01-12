//
//  ChattingViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/10/25.
//

import UIKit

final class ChattingViewController: UIViewController, Presentable {
    
    var list: [Chat]?
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        configureUIWhenViewDidLoad()
        registerTableViewCell()
    }
    
    func configureView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        
    }
    
    func setupDelegateAndDatasource() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerTableViewCell() {
        let meCellNib = UINib(nibName: ChatWrittenByMeTableViewCell.identifier, bundle: nil)
        tableView.register(meCellNib, forCellReuseIdentifier: ChatWrittenByMeTableViewCell.identifier)
        
        let othersCellNib = UINib(nibName: ChatWrittenByOtherTableViewCell.identifier, bundle: nil)
        tableView.register(othersCellNib, forCellReuseIdentifier: ChatWrittenByOtherTableViewCell.identifier)
    }
    
    
}


extension ChattingViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let row = list?[indexPath.row] else { return ChatWrittenByMeTableViewCell() }
        
        if row.user.rawValue == User.user.rawValue {
            guard let myCell = tableView.dequeueReusableCell(withIdentifier: ChatWrittenByMeTableViewCell.identifier, for: indexPath) as? ChatWrittenByMeTableViewCell else { return ChatWrittenByMeTableViewCell() }
            
            myCell.configureCell(row: row)
            return myCell

        } else {
            guard let otherCell = tableView.dequeueReusableCell(withIdentifier: ChatWrittenByOtherTableViewCell.identifier, for: indexPath) as? ChatWrittenByOtherTableViewCell else { return ChatWrittenByOtherTableViewCell() }
            
            otherCell.configureCell(row: row)
            return otherCell
        }
    }
    
    
}
