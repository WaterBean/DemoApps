//
//  ChattingViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/10/25.
//

import UIKit

final class ChattingViewController: UIViewController, Presentable {
    
    @IBOutlet private var tableView: UITableView!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var inputTextView: UITextView!
    var list: [Chat]?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUIWhenViewDidLoad()
        registerTableViewCell()
        scrollToIndex()
         
    }
    
    func configureView() {
        tableView.rowHeight = UITableView.automaticDimension
        tableView.separatorStyle = .none
        inputTextView.isEditable = true
        inputTextView.backgroundColor = .systemGray5
        inputTextView.clipsToBounds = true
        inputTextView.layer.cornerRadius = 12
        sendButton.setImage(UIImage(systemName: "paperplane"), for: .normal)
        sendButton.setTitle("", for: .normal)
        sendButton.tintColor = .systemGray3
        sendButton.backgroundColor = .systemGray5
        sendButton.layer.cornerRadius = 12
        sendButton.clipsToBounds = true
    }
    
    func setupDelegateAndDatasource() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func registerTableViewCell() {
        let meCellNib = UINib(nibName: ChatWrittenByMeTableViewCell.identifier, bundle: nil)
        tableView.register(meCellNib, forCellReuseIdentifier: ChatWrittenByMeTableViewCell.identifier)
        
        let othersCellNib = UINib(nibName: ChatWrittenByOtherTableViewCell.identifier, bundle: nil)
        tableView.register(othersCellNib, forCellReuseIdentifier: ChatWrittenByOtherTableViewCell.identifier)
    }
    
    private func scrollToIndex() {
        let index = IndexPath(row: (list?.count ?? 1) - 1, section: 0)
        tableView.scrollToRow(at: index, at: .bottom, animated: true)
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
