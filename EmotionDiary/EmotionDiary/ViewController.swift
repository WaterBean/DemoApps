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
    
    private var emotionInfo: [Int: (String, Int)] = [
        0: ("행복해", 2), 1: ("사랑해", 20), 2: ("좋아해", 3),
        3: ("당황해", 1), 4: ("속상해", 3), 5: ("우울해", 6),
        6: ("심심해", 0), 7: ("행복해", 1), 8: ("행복해", 0)]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = UIColor.init(red: 231, green: 211, blue: 221, alpha: 1).cgColor
        configureBarButtonItem()
        configureEmotionButtonsAndLabels()
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
        emotionLabels.forEach { updateEmotionLabel(at: $0.tag)
        }
    }

    private func updateEmotionLabel(at index: Int) {
        guard let (name, count) = emotionInfo[index] else { return }
        emotionLabels[index].text = "\(name)  \(count)"
    }

    @IBAction private func emotionButtonTapped(_ sender: UIButton) {
        emotionInfo[sender.tag]?.1 += 1
        updateEmotionLabel(at: sender.tag)
    }
    
}

