//
//  LevelViewController.swift
//  SeSACDay22Assignment
//
//  Created by Jack on 1/23/25.
//

import UIKit
import SnapKit

final class LevelViewController: UIViewController {

    let segmentedControl = UISegmentedControl(items: ["상", "중", "하"])
    var closure: ((String) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    @objc func okButtonTapped() {
        guard let level = self.segmentedControl.titleForSegment(at: segmentedControl.selectedSegmentIndex) else { print("저장 실패"); return }
        closure?(level)
        navigationController?.popViewController(animated: true)
    }
    
    func configureView() {
        navigationItem.title = "레벨"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "확인", style: .plain, target: self, action: #selector(okButtonTapped))
        view.backgroundColor = .white
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.centerX.top.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
        segmentedControl.selectedSegmentIndex = 0
    }
}
