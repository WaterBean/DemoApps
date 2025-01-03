//
//  ShoppingTableViewController.swift
//  TamagotchiApp
//
//  Created by 한수빈 on 1/2/25.
//

import UIKit

class ShoppingTableViewController: UITableViewController {

    @IBOutlet var textField: UITextField!
    @IBOutlet var addButton: UIButton!
    
    var list: [ShoppingItem] = [
        ShoppingItem("그립톡 구매하기", isChecked: true, isStarred: false),
        ShoppingItem("사이다 구매", isChecked: false, isStarred: false),
        ShoppingItem("아이패드 케이스 최저가 알아보기", isChecked: false, isStarred: true),
        ShoppingItem("양말", isChecked: false, isStarred: true)
    ] {
        didSet {
            tableView.reloadData()
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
        list.append(ShoppingItem(textField.text!))
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

        // ???: - viewWithTag + 타입 변환을 사용하지 않으면서 테이블 뷰의 요소를 가져올 방법은 없을까?
        // 조금 더 시멘틱하게, 타입 safety하게 작성하고 싶음
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
    
    @objc func checkboxTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view?.superview?.superview?.superview as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            list[indexPath.row].isChecked.toggle()
        }
    }

    @objc func starTapped(_ sender: UITapGestureRecognizer) {
        if let cell = sender.view?.superview?.superview?.superview as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell) {
            list[indexPath.row].isStarred.toggle()
        }
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
