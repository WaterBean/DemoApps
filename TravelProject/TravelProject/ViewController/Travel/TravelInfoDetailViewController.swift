//
//  TravelInfoDetailViewController.swift
//  TravelProject
//
//  Created by 한수빈 on 1/7/25.
//

import UIKit
import Kingfisher

final class TravelInfoDetailViewController: UIViewController {

    var travelInfo: Travel?
    
    @IBOutlet private var detailImageView: UIImageView!
    @IBOutlet private var titleLabel: UILabel!
    @IBOutlet private var subTitleLabel: UILabel!
    @IBOutlet private var popButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()

        titleLabel.text = travelInfo?.title
        subTitleLabel.text = travelInfo?.description
        
        // url string이 nil이면 종료되기 때문에 아래 코드가 실행이 안됨
        guard let strUrl = travelInfo?.travel_image else { return }
        let url = URL(string: strUrl)
        detailImageView.kf.setImage(with: url)
    }
    
    func configureView() {
        
        navigationItem.title = "관광지 화면"
        
        detailImageView.contentMode = .scaleAspectFill
        detailImageView.layer.cornerRadius = 12
        detailImageView.clipsToBounds = true
        
        titleLabel.font = .boldSystemFont(ofSize: 32)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        
        subTitleLabel.font = .boldSystemFont(ofSize: 24)
        subTitleLabel.numberOfLines = 0
        subTitleLabel.textAlignment = .center
        
        var config = popButton.configuration
        
        config?.cornerStyle = .capsule
        config?.attributedTitle = AttributedString("다른 관광지 보러가기", attributes: AttributeContainer([.font: UIFont.boldSystemFont(ofSize: 18)]))
        config?.buttonSize = .large
        config?.background.backgroundColor = UIColor(red: 0.2, green: 0.6, blue: 1.0, alpha: 0.7)
        
        popButton.configuration = config
        
    }
    
    

    @IBAction func popButtonTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
}
