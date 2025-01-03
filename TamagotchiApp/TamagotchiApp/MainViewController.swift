//
//  MainViewController.swift
//  TamagotchiApp
//
//  Created by 한수빈 on 1/1/25.
//

import UIKit

final class MainViewController: UIViewController {
    
    @IBOutlet var profileButton: UIBarButtonItem!
    @IBOutlet var bubbleImageView: UIImageView!
    @IBOutlet var bubbleLabel: UILabel!
    @IBOutlet var tamagotchiImageView: UIImageView!
    @IBOutlet var tamagotchiStatusLabel: UILabel!
    @IBOutlet var tamagotchiFeedNumberTextField: UITextField!
    @IBOutlet var tamagotchiWaterNumberTextField: UITextField!
    @IBOutlet var tamagotchiFeedButton: UIButton!
    @IBOutlet var tamagotchiWaterButton: UIButton!
    @IBOutlet var tamagotchiNameLabel: MyLabel!
    
    let user = User.shared
    let tamagotchi = Tamagotchi()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backBarButtonItem = UIBarButtonItem(title: "설정", style: .plain, target: self, action: nil)
        backBarButtonItem.tintColor = .black
        navigationItem.backBarButtonItem = backBarButtonItem
        
        profileButton.image = UIImage(systemName: "person.circle")
        profileButton.tintColor = .black
        
        bubbleImageView.image = .bubble
        
        bubbleLabel.textAlignment  = .center
        bubbleLabel.numberOfLines = 0
        
        tamagotchiImageView.contentMode = .scaleAspectFit
        tamagotchiStatusLabel.text = tamagotchi.getStatusMessage()
        tamagotchiStatusLabel.font = .systemFont(ofSize: 12)
        
        tamagotchiStatusLabel.textAlignment  = .center
        tamagotchiStatusLabel.numberOfLines = 5
        
        
        tamagotchiFeedNumberTextField.configCommonStyle(placeholder: "밥주세용")
        tamagotchiWaterNumberTextField.configCommonStyle(placeholder: "물주세용")
        
        tamagotchiNameLabel.text = "방실방실 다마고치"
        tamagotchiNameLabel.textAlignment = .center
        tamagotchiNameLabel.layer.borderWidth = 1
        tamagotchiNameLabel.layer.borderColor = UIColor.black.cgColor
        tamagotchiNameLabel.layer.cornerRadius = 6
        
        // TODO: - button configuration, updatehandler로 스타일, 로직 짜보기
        var config = tamagotchiFeedButton.configuration
        config?.title = "밥먹기"
        config?.buttonSize = .small
        config?.image = UIImage(systemName: "drop.circle")
        config?.contentInsets = .init(top: 10, leading: 6, bottom: 10, trailing: 6)
        config?.imagePadding = 2
        config?.baseForegroundColor = .black
        tamagotchiFeedButton.configuration = config
        tamagotchiFeedButton.layer.cornerRadius = 6
        tamagotchiFeedButton.layer.borderWidth = 1
        
        tamagotchiWaterButton.configurationUpdateHandler = { button in
            var config = button.configuration
            config?.title = "물먹기"
            config?.buttonSize = .small
            config?.image = button.isHighlighted
            ? UIImage(systemName: "leaf.circle.fill")
            : UIImage(systemName: "leaf.circle")
            config?.contentInsets = .init(top: 10, leading: 6, bottom: 10, trailing: 6)
            config?.imagePadding = 2
            config?.baseForegroundColor = .black
            button.configuration = config
            
            button.layer.cornerRadius = 6
            button.layer.borderWidth = 1
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "\(user.name)님의 다마고치"
        bubbleLabel.text = tamagotchi.getMessage()
        tamagotchiImageView.image = UIImage(named: "2-\(tamagotchi.calculateLevel())")
        
    }
    
    @IBAction func feedButtonTapped(_ sender: UIButton) {
        defer {
            tamagotchiStatusLabel.text = tamagotchi.getStatusMessage()
            let level = tamagotchi.calculateLevel()
            tamagotchiImageView.image = UIImage(named: "2-\(level)")
        }
        
        guard let feedNumber = Int((tamagotchiFeedNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) ?? "") else {
            tamagotchi.foodCount += 1
            return
        }
        
        if 1..<100 ~= feedNumber {
            tamagotchi.foodCount += feedNumber
            bubbleLabel.text = "밥을 잘먹었더니 레벨업 했어요 고마워요 \(user.name)님."
        }
    }
    
    @IBAction func waterButtonTapped(_ sender: UIButton) {
        defer {
            tamagotchiStatusLabel.text = tamagotchi.getStatusMessage()
            let level = tamagotchi.calculateLevel()
            tamagotchiImageView.image = UIImage(named: "2-\(level)")
        }
        
        guard let waterNumber = Int((tamagotchiWaterNumberTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)) ?? "") else {
            tamagotchi.waterCount += 1
            return
        }
        
        if 1..<50 ~= waterNumber {
            tamagotchi.waterCount += waterNumber
            bubbleLabel.text = "물을 잘먹었더니 레벨업 했어요 고마워요 \(user.name)님."
        }
    }
    
    
}


// MARK: - Custom Class
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
    
    let minimumLevel = 1
    let maximumLevel = 10
    private let messageList: [String] = ["배고파요... 밥주세요!", "좋은 하루에요."]
    var level: Int {
        get { UserDefaults.standard.integer(forKey: "level") }
        set { UserDefaults.standard.set(newValue, forKey: "level") }
    }
    var foodCount: Int {
        get { UserDefaults.standard.integer(forKey: "food") }
        set { UserDefaults.standard.set(newValue, forKey: "food") }
    }
    var waterCount: Int {
        get { UserDefaults.standard.integer(forKey: "water") }
        set { UserDefaults.standard.set(newValue, forKey: "water") }
    }
    
    @MainActor func getMessage()-> String {
        return User.shared.name + "님, " + messageList.randomElement()!
    }
    func getStatusMessage()-> String {
        return "LV\(calculateLevel()) · 밥알 \(self.foodCount)개 · 물방울 \(self.waterCount)개"
    }
    
    @discardableResult
    func calculateLevel () -> Int {
        let doubleFoodCount = Double((foodCount)) / 5.0
        let doubleWaterCount = Double((waterCount)) / 2.0
        
        let level = (doubleFoodCount + doubleWaterCount) / 10
        let intLevel = Int(level)
        
        let calculatedLevel = switch intLevel {
        case ..<minimumLevel: minimumLevel
        case minimumLevel...maximumLevel: intLevel
        case maximumLevel... : maximumLevel
        default: minimumLevel
        }
        self.level = calculatedLevel
        print(doubleFoodCount, doubleWaterCount, level, calculatedLevel)
        return calculatedLevel
    }
    
}




// MARK: - Custom UI
extension UITextField {
    func addBottomLine() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: self.frame.height - 2, width: self.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        self.borderStyle = .none
        self.layer.addSublayer(bottomLine)
    }
    
    func configCommonStyle(placeholder: String) {
        self.placeholder = placeholder
        self.textAlignment = .center
        self.keyboardType = .numberPad
        self.addBottomLine()
    }
}

final class MyLabel: UILabel {
    
    var topInset: CGFloat = 4.0
    var bottomInset: CGFloat = 4.0
    var leftInset: CGFloat = 8.0
    var rightInset: CGFloat = 8.0
    
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }
    
    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        return CGSize(width: size.width + leftInset + rightInset,
                      height: size.height + topInset + bottomInset)
    }
    
    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }
    
}
