//
//  DetailViewController.swift
//  RxDemo
//
//  Created by 한수빈 on 2/19/25.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

final class DetailViewController: UIViewController {
    
    private let viewModel = DetailViewModel()
    private let disposeBag = DisposeBag()
    
    convenience init(person: Person) {
        self.init(nibName: nil, bundle: nil)
        bind(person: person)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind(person: Person) {
        let input = DetailViewModel.Input(model: person)
        let output = viewModel.transform(input: input)
        
        output.model
            .map { $0.name }
            .bind(to: navigationItem.rx.title)
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .lightGray
    }
    
}

