//
//  ViewController.swift
//  EmotionDiary
//
//  Created by 한수빈 on 12/26/24.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet private var emotionButtons: [UIButton]!
    @IBOutlet private var emotionLabels: [UILabel]!
    @IBOutlet private var navBarButtonItem: UIBarButtonItem!
    
    private var emotionInfo: [Int: (name: String, count: Int)] = [
        0: ("행복해", 0), 1: ("사랑해", 0), 2: ("좋아해", 0),
        3: ("당황해", 0), 4: ("속상해", 0), 5: ("우울해", 0),
        6: ("심심해", 0), 7: ("그냥해", 0), 8: ("계속해", 0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = UIColor.init(red: 231, green: 211, blue: 221, alpha: 1).cgColor
        configureBarButtonItem()
        loadEmotionInfo()
        configureEmotionButtonsAndLabels()
    }
    
    private func loadEmotionInfo() {
        emotionInfo.forEach { (key: Int, value: (name: String, count: Int)) in
            let savedCount = UserDefaults.standard.integer(forKey: String(key))
            print("\(emotionInfo[key]!) -> count: \(savedCount)")
            emotionInfo[key] = (name: value.name, count: savedCount)
        }
    }
    
    private func configureBarButtonItem() {
        navBarButtonItem.setSymbolImage(UIImage(systemName: "list.bullet") ?? UIImage(), contentTransition: .automatic)
        navBarButtonItem.tintColor = .black
    }
    
    private func configureEmotionButtonsAndLabels() {
        for i in 0..<9  {
            emotionButtons[i].tag = i
            emotionLabels[i].tag = i
        }
        
        updateEmotionLabels()
        
        emotionButtons.forEach {
            $0.setImage(UIImage(named: "mono_slime\($0.tag+1)"), for: .normal)
        }
    }
    
    private func updateEmotionLabels() {
        emotionLabels.forEach {
            updateEmotionLabel(at: $0.tag)
            $0.textAlignment = .center
        }
    }

    private func updateEmotionLabel(at index: Int) {
        guard let (name, count) = emotionInfo[index] else { return }
        emotionLabels[index].text = "\(name)  \(count)"
        UserDefaults.standard.set(count, forKey: String(index))
    }

    @IBAction private func emotionButtonTapped(_ sender: UIButton) {
        emotionInfo[sender.tag]?.1 += 1
        updateEmotionLabel(at: sender.tag)
    }
    
}

