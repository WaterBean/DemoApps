//
//  upDownGameProtocol.swift
//  MapProject
//
//  Created by 한수빈 on 1/9/25.
//

import UIKit

/// 게임을 플레이할 때 필요한 프로토콜
protocol UpDownGameProtocol {
    
    /// 첫 화면에서 입력한 숫자
    var userInputMaxNumber: Int? { get set }
    
    /// 한 게임에서 시도한 횟수
    var tryCount: Int { get set }
    
    /// 한 게임에서 선택한 숫자
    var selectNumber: Int { get set }
    
    /// 한 게임의 정답 숫자
    var correctAnswer: Int { get }
    
    /// 입력한 숫자 기반으로 게임 리스트 생성
    func generateGameList(in maxNumber: Int) -> [Int]
    
    /// 선택한 숫자가 up down인지 검사하는 메서드
    func selectNumberIsCorrect(select number: Int) -> ResultCase
    
    /// 선택한 숫자가 Up일 때 실행
    func whenUserSelectUp()
    
    /// 선택한 숫자가 Down일 때 실행
    func whenUserSelectDown()
    
    /// 선택한 숫자가 정답일 때 실행
    func whenUserSelectCorrectAnswer()
    
}

enum ResultCase {
    case up
    case down
    case correct
}


/// ViewController 요구사항
protocol ViewControllerRequirement: AnyObject {
    // template Method
    func configureUIWhenViewDidload()
    
    func configureView()
    func setupDelegateAndDatasource()
    
}


extension ViewControllerRequirement {
    func configureUIWhenViewDidload() {
        configureView()
        setupDelegateAndDatasource()
    }
    
}

/// 재사용 뷰 요구사항
protocol ReusableViewProtocol: AnyObject {
    static var identifier: String { get }
}

extension UICollectionViewCell: ReusableViewProtocol {
    static var identifier: String {
        return String(describing: self)
    }
    
}
