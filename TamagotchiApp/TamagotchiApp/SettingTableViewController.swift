//
//  SettingTableViewController.swift
//  TamagotchiApp
//
//  Created by 한수빈 on 1/2/25.
//

import UIKit

class SettingTableViewController: UITableViewController {

    let rowList: [[String]] = [["공지사항", "실험실", "버전 정보"],["개인/보안", "알림", "채팅", "멀티프로필"], ["고객센터/도움말"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return rowList.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowList[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        var config = cell.defaultContentConfiguration()
        config.textProperties.font = .systemFont(ofSize: 13)
        config.text = rowList[indexPath.section][indexPath.row]
        cell.contentConfiguration = config
        
        return cell
    }
    

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return switch section {
        case 0: "전체 설정"
        case 1: "개인 설정"
        case 2: "기타"
        default: "섹션"
        }
        
        
    }

}
