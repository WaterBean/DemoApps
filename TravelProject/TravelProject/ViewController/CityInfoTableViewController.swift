//
//  CityInfoTableViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/6/25.
//

import UIKit

final class CityInfoTableViewController: UITableViewController {
    
    @IBOutlet private var textField: UITextField!
    @IBOutlet private var segmentedControl: UISegmentedControl!
    
    private let list = CityInfo().city
    private lazy var selectedList = list {
        didSet {
            filteredList = selectedList
        }
    }
    private lazy var filteredList = list {
        didSet {
            self.tableView.reloadData()
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: CityInfoTableViewCell.identifier, bundle: Bundle.main), forCellReuseIdentifier: CityInfoTableViewCell.identifier)
        tableView.rowHeight = 136
        tableView.separatorStyle = .none
        
        navigationItem.title = "인기 도시"
        
        textField.placeholder = "도시를 검색하세요"
        textField.returnKeyType = .search
        
        segmentedControl.setTitle("모두", forSegmentAt: 0)
        segmentedControl.setTitle("국내", forSegmentAt: 1)
        segmentedControl.setTitle("해외", forSegmentAt: 2)
        
    }
    
    @IBAction private func textFieldEditing(_ sender: UITextField) {
        if let text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            searchCity(text)
        }
    }
    
    @IBAction func textFieldDidEndOnExit(_ sender: UITextField) {
        if let text = sender.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
            searchCity(text)
        }
        view.endEditing(true)
    }
    
    
    @IBAction private func segmentedControlSelected(_ sender: UISegmentedControl) {
        
        selectedList = switch sender.selectedSegmentIndex {
        case 1: list.filter { $0.domestic_travel }
        case 2: list.filter { !$0.domestic_travel }
        default: CityInfo().city
        }
        view.endEditing(true)
    }
    
    private func searchCity(_ keyword: String) {
        if keyword == "" {
            filteredList = selectedList
        } else {
            filteredList = selectedList.filter {
                $0.city_name.contains(keyword) ||
                $0.city_english_name.contains(keyword) ||
                $0.city_english_name.contains(keyword.capitalized) ||
                $0.city_explain.contains(keyword)
            }
        }
    }

    
    // MARK: - Table View Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CityInfoTableViewCell.identifier) as! CityInfoTableViewCell
        let row = filteredList[indexPath.row]
        
        cell.configureCell(row: row)
        
        cell.cityNameLabel.attributedText = highlightingLabel(text: cell.cityNameLabel.text!)
        cell.explainLabel.attributedText = highlightingLabel(text: cell.explainLabel.text!)
        
        return cell
    }
    
    private func highlightingLabel(text: String)-> NSMutableAttributedString{
        let attributeString = NSMutableAttributedString(string: text)
        attributeString.addAttribute(.foregroundColor, value: UIColor.systemOrange, range: (text as NSString).range(of: textField.text!))
        return attributeString
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        view.endEditing(true)
    }
    
}
