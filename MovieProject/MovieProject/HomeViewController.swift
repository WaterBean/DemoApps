//
//  HomeViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 12/28/24.
//

import UIKit

final class HomeViewController: UIViewController {
    
    @IBOutlet private var mainRecommendContentsImageView: UIImageView!
    @IBOutlet private var firstRisingContentsImageView: UIImageView!
    @IBOutlet private var secondRisingContentsImageView: UIImageView!
    @IBOutlet private var thirdRisingContentsImageView: UIImageView!
    
    
    @IBOutlet private var isTopTen: [UIImageView]!
    @IBOutlet private var isNewEpisode: [UIImageView]!
    @IBOutlet private var isNewSeriesWatchingNow: [UIImageView]!
    
    
    private var contentsList: [ContentModel] = [
        ContentModel(image: #imageLiteral(resourceName: "1"), isTopTen: false, isNewEpisode: true, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "2"), isTopTen: false, isNewEpisode: true, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "3"), isTopTen: false, isNewEpisode: true, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "4"), isTopTen: false, isNewEpisode: true, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "5"), isTopTen: false, isNewEpisode: true, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "암살"), isTopTen: true, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "극한직업"), isTopTen: true, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "스즈메의문단속"), isTopTen: true, isNewEpisode: true, isNewSeriesWatchingNow: true),
        ContentModel(image: #imageLiteral(resourceName: "어벤져스엔드게임"), isTopTen: true, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "서울의봄"), isTopTen: true, isNewEpisode: true, isNewSeriesWatchingNow: true),
        ContentModel(image: #imageLiteral(resourceName: "부산행"), isTopTen: true, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "베테랑"), isTopTen: true, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "육사오"), isTopTen: false, isNewEpisode: false, isNewSeriesWatchingNow: true),
        ContentModel(image: #imageLiteral(resourceName: "해운대"), isTopTen: false, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "아바타물의길"), isTopTen: true, isNewEpisode: true, isNewSeriesWatchingNow: true),
        ContentModel(image: #imageLiteral(resourceName: "도둑들"), isTopTen: false, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "명량"), isTopTen: true, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "신과함께죄와벌"), isTopTen: true, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "오펜하이머"), isTopTen: true, isNewEpisode: true, isNewSeriesWatchingNow: true),
        ContentModel(image: #imageLiteral(resourceName: "태극기휘날리며"), isTopTen: false, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "노량"), isTopTen: true, isNewEpisode: true, isNewSeriesWatchingNow: true),
        ContentModel(image: #imageLiteral(resourceName: "콘크리트유토피아"), isTopTen: true, isNewEpisode: true, isNewSeriesWatchingNow: true),
        ContentModel(image: #imageLiteral(resourceName: "택시운전사"), isTopTen: false, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "신과함께인과연"), isTopTen: true, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "범죄도시3"), isTopTen: true, isNewEpisode: true, isNewSeriesWatchingNow: true),
        ContentModel(image: #imageLiteral(resourceName: "알라딘"), isTopTen: false, isNewEpisode: false, isNewSeriesWatchingNow: false),
        ContentModel(image: #imageLiteral(resourceName: "밀수"), isTopTen: true, isNewEpisode: true, isNewSeriesWatchingNow: true),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        playButtonTapped(UIButton())
    }
    
    private func updateRandomContents() {
        let imageViews: [UIImageView] = [firstRisingContentsImageView, secondRisingContentsImageView, thirdRisingContentsImageView, mainRecommendContentsImageView]
        
        contentsList.shuffle()
        for (index, imageView) in imageViews.enumerated() {
            imageView.image = contentsList[index].image
        }
    }
    
    private func updateContentBadges() {
        for index in 0...2 {
            isTopTen[index].isHidden = !contentsList[index].isTopTen
            isNewEpisode[index].isHidden = !contentsList[index].isNewEpisode
            isNewSeriesWatchingNow[index].isHidden = !contentsList[index].isNewSeriesWatchingNow
        }
    }
    
    @IBAction private func playButtonTapped(_ sender: UIButton) {
        updateRandomContents()
        updateContentBadges()
    }
}


struct ContentModel {
    let image: UIImage
    let isTopTen: Bool
    let isNewEpisode: Bool
    let isNewSeriesWatchingNow: Bool
}
