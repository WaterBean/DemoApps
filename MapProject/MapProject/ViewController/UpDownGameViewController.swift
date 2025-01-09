//
//  UpDownGameViewController.swift
//  MapProject
//
//  Created by 한수빈 on 1/9/25.
//

import UIKit

final class UpDownGameViewController: UIViewController, ViewControllerRequirement, ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }

    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var tryCountLabel: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var resultButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
}
