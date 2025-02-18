//
//  SimpleTableViewExampleViewController.swift
//  RxDemo
//
//  Created by 한수빈 on 2/18/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class SimpleTableViewExampleViewController: UIViewController {

    private lazy var tableView = {
        let view = UITableView()
        view.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(view)
        
        view.snp.makeConstraints {
            $0.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        return view
    }()
    
    let disposeBag = DisposeBag()
    
    let items = Observable.just(
        (0..<20).map { "\($0)" }
    )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        bind()
    }

    func bind() {
        items
            .bind(to: tableView.rx.items(cellIdentifier: "cell", cellType: UITableViewCell.self)) { row, element, cell in
                cell.accessoryType = .detailButton
                cell.textLabel?.text = "\(element) @ row \(row)"
            }
            .disposed(by: disposeBag)
        

        tableView.rx.modelSelected(String.self)
            .bind { value in
                Alert.simpleAlert(owner: self, "\(value)가 선택되었음")
            }
            .disposed(by: disposeBag)
        
        tableView.rx.itemAccessoryButtonTapped
            .bind { indexPath in
                Alert.simpleAlert(owner: self, "\(indexPath)번째 악세사리 버튼 탭")
            }
            .disposed(by: disposeBag)
    
    }
    
}

final class Alert {
    static func simpleAlert(owner: UIViewController,_ contents: String) {
        let alert = UIAlertController(title: "알림", message: contents, preferredStyle: .alert)
        let action = UIAlertAction(title: "확인", style: .default)
        alert.addAction(action)
        owner.present(alert, animated: true)
    }
}
