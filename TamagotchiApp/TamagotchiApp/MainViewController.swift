//
//  MainViewController.swift
//  TamagotchiApp
//
//  Created by 한수빈 on 1/1/25.
//

import UIKit

final class MainViewController: UIViewController {

    @IBOutlet var navigationBar: UINavigationItem!
    @IBOutlet var profileButton: UIBarButtonItem!
    @IBOutlet var bubbleImageView: UIImageView!
    @IBOutlet var bubbleLabel: UILabel!
    @IBOutlet var tamagotchiImageView: UIImageView!
    @IBOutlet var tamagotchiStatusLabel: UILabel!
    @IBOutlet var tamagotchiFeedNumberTextField: UITextField!
    @IBOutlet var tamagotchiWaterNumberTextField: UITextField!
    @IBOutlet var tamagotchiFeedButton: UIButton!
    @IBOutlet var tamagotchiWaterButton: UIButton!
    
    let user = User.shared
    let tamagotchi = Tamagotchi()
    let bottomLine = CALayer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        profileButton.image = UIImage(systemName: "person.circle")
        
        bubbleImageView.image = .bubble
        
        bubbleLabel.textAlignment  = .center
        bubbleLabel.numberOfLines = 5
        
        tamagotchiImageView.image = UIImage(named: "2-1")
        tamagotchiImageView.contentMode = .scaleAspectFit
        tamagotchiStatusLabel.text = "LV\(tamagotchi.level) 밥알 \(tamagotchi.foodCount)개 물방울 \(tamagotchi.waterCount)개"
        
        tamagotchiStatusLabel.textAlignment  = .center
        tamagotchiStatusLabel.numberOfLines = 5
        
        tamagotchiFeedNumberTextField.addBottomLine()
        tamagotchiFeedNumberTextField.placeholder = "밥주세용"
        
        tamagotchiWaterNumberTextField.addBottomLine()
        tamagotchiWaterNumberTextField.placeholder = "물주세용"

        // TODO: - button configuration, updatehandler로 스타일, 로직 짜보기
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.title = "\(user.name)님의 다마고치"
        bubbleLabel.text = tamagotchi.getMessage()
        
    }
    
    @IBAction func feedButtonTapped(_ sender: UIButton) {
        bubbleLabel.text = "밥과 물을 잘먹었더니 레벨업 했어요 고마워요 \(user.name)님."
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        bubbleLabel.text = "밥과 물을 잘먹었더니 레벨업 했어요 고마워요 \(user.name)님."
    }
    
    

}

final class User {
    @MainActor static let shared = User()
    private init() { }
    var name: String {
        get {
            UserDefaults.standard.string(forKey: "userName") ?? "대장"
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userName")
        }
    }
    
    
}

final class Tamagotchi {
    
    private let messageList: [String] = ["배고파요... 밥주세요!", "좋은 하루에요."]
    var level: Int {
        get {
            UserDefaults.standard.integer(forKey: "level")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "level")
        }
    }
    var foodCount: Int {
        get {
            UserDefaults.standard.integer(forKey: "food")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "food")
        }
    }
    var waterCount: Int {
        get {
            UserDefaults.standard.integer(forKey: "water")
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "water")
        }
    }
    
    @MainActor func getMessage()-> String {
        return User.shared.name + "님, " + messageList.randomElement()!
    }
}


extension UITextField {
    func addBottomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 2, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
}
