//
//  ShoppingTableViewController.swift
//  TamagotchiApp
//
//  Created by 한수빈 on 1/2/25.
//

import UIKit

final class ShoppingTableViewController: UITableViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    private var list: [ShoppingItem] = [
        ShoppingItem("그립톡 구매하기", isChecked: true, isStarred: false),
        ShoppingItem("사이다 구매", isChecked: false, isStarred: false),
        ShoppingItem("아이패드 케이스 최저가 알아보기", isChecked: false, isStarred: true),
        ShoppingItem("양말", isChecked: false, isStarred: true)
    ] {
        didSet {
            print(self.list)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 50

        textField.borderStyle = .roundedRect
        textField.backgroundColor = .systemGray6
        
        addButton.tintColor = .black
    }
 
    @IBAction func addButtonTapped(_ sender: UIButton) {
        let text = textField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if text == "" {
            
        } else {
            list.append(ShoppingItem(text))
            tableView.reloadData()
        }
    }
    
    @objc func checkboxTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view?.superview?.superview?.superview as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            list[indexPath.row].isChecked.toggle()
            tableView.reloadData()
        }
    }

    @objc func starTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view?.superview?.superview?.superview as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            list[indexPath.row].isStarred.toggle()
            tableView.reloadData()
        }
    }
    
}

// MARK: - TableViewController Method
extension ShoppingTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        let data = list[indexPath.row]
        
        cell.backgroundColor = .white
        
        let checkbox = cell.contentView.viewWithTag(1) as? UIImageView
        let contents = cell.contentView.viewWithTag(2) as? UILabel
        let star = cell.contentView.viewWithTag(3) as? UIImageView
        let cellBackgroundView = cell.contentView.viewWithTag(4)

        checkbox?.isUserInteractionEnabled = true
        star?.isUserInteractionEnabled = true
                
        let checkboxTap = UITapGestureRecognizer(target: self, action: #selector(checkboxTapped(_:)))
        checkbox?.addGestureRecognizer(checkboxTap)
        checkbox?.image = UIImage(systemName: data.isChecked ? "checkmark.square.fill" : "checkmark.square")
        checkbox?.tintColor = .black

        let starTap = UITapGestureRecognizer(target: self, action: #selector(starTapped(_:)))
        star?.addGestureRecognizer(starTap)
        star?.image = UIImage(systemName: data.isStarred ? "star.fill" : "star")
        star?.tintColor = .black
        
        contents?.text = data.contents
        
        cellBackgroundView?.backgroundColor = .systemGray6
        cellBackgroundView?.clipsToBounds = true
        cellBackgroundView?.layer.cornerRadius = 4
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            list.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade) // tableView.reloadData() 기능을 내장
        }
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let likeAction = UIContextualAction(style: .normal, title: "즐겨찾기", handler: { [unowned self] (action, view, completionHandler) in
            self.list[indexPath.row].isStarred.toggle()
            if let cell = tableView.cellForRow(at: indexPath) {
                let star = cell.contentView.viewWithTag(3) as? UIImageView
                let isStarred = self.list[indexPath.row].isStarred
                star?.image = UIImage(systemName: isStarred ? "star.fill" : "star")
            }
            completionHandler(true)
        })
        let checkAction = UIContextualAction(style: .normal, title: "완료", handler: { [unowned self] (action, view, completionHandler) in
            self.list[indexPath.row].isChecked.toggle()
            if let cell = tableView.cellForRow(at: indexPath) {
                let check = cell.contentView.viewWithTag(1) as? UIImageView
                let isChecked = self.list[indexPath.row].isChecked
                check?.image = UIImage(systemName: isChecked ? "checkmark.square.fill" : "checkmark.square")
            }
            completionHandler(true)
        })
        
        likeAction.backgroundColor = .orange
        
        checkAction.image = UIImage(systemName: "checkmark")
        checkAction.backgroundColor = .systemGreen
        
        return UISwipeActionsConfiguration(actions: [likeAction,checkAction])
    }
    
}

// MARK: - Model
struct ShoppingItem {
    let contents: String
    var isChecked: Bool
    var isStarred: Bool
    
    init(_ contents: String, isChecked: Bool, isStarred: Bool) {
        self.contents = contents
        self.isChecked = isChecked
        self.isStarred = isStarred
    }
    
    init(_ contents: String) {
        self.contents = contents
        self.isChecked = false
        self.isStarred = false
    }
    
}
