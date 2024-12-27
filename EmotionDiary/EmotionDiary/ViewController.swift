//
//  ViewController.swift
//  EmotionDiary
//
//  Created by 한수빈 on 12/26/24.
//

import UIKit

// TODO: - Refactor IBOutlet to IBOutlet Collection
class ViewController: UIViewController {
    
    @IBOutlet var button1: UIButton!
    @IBOutlet var button2: UIButton!
    @IBOutlet var button3: UIButton!
    @IBOutlet var button4: UIButton!
    @IBOutlet var button5: UIButton!
    @IBOutlet var button6: UIButton!
    @IBOutlet var button7: UIButton!
    @IBOutlet var button8: UIButton!
    @IBOutlet var button9: UIButton!
    
    
    @IBOutlet var label1: UILabel!
    @IBOutlet var label2: UILabel!
    @IBOutlet var label3: UILabel!
    @IBOutlet var label4: UILabel!
    @IBOutlet var label5: UILabel!
    @IBOutlet var label6: UILabel!
    @IBOutlet var label7: UILabel!
    @IBOutlet var label8: UILabel!
    @IBOutlet var label9: UILabel!
            
    @IBOutlet var navBarButtonItem: UIBarButtonItem!
    
    var values = [2, 20, 3, 1, 3, 6, 0, 1, 0]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.layer.backgroundColor = UIColor.init(red: 231, green: 211, blue: 221, alpha: 1).cgColor
                
        navBarButtonItem.setSymbolImage(UIImage(systemName: "list.bullet") ?? UIImage(), contentTransition: .automatic)
        navBarButtonItem.tintColor = .black
        
        
        label1.text = "행복해 \(values[0])"
        label2.text = "사랑해 \(values[1])"
        label3.text = "좋아해 \(values[2])"
        label4.text = "당황해 \(values[3])"
        label5.text = "속상해 \(values[4])"
        label6.text = "우울해 \(values[5])"
        label7.text = "심심해 \(values[6])"
        label8.text = "행복해 \(values[7])"
        label9.text = "행복해 \(values[8])"
        
        label1.textAlignment = .center
        label2.textAlignment = .center
        label3.textAlignment = .center
        label4.textAlignment = .center
        label5.textAlignment = .center
        label6.textAlignment = .center
        label7.textAlignment = .center
        label8.textAlignment = .center
        label9.textAlignment = .center
        
        button1.setImage(.monoSlime1, for: .normal)
        button2.setImage(.monoSlime2, for: .normal)
        button3.setImage(.monoSlime3, for: .normal)
        button4.setImage(.monoSlime4, for: .normal)
        button5.setImage(.monoSlime5, for: .normal)
        button6.setImage(.monoSlime6, for: .normal)
        button7.setImage(.monoSlime7, for: .normal)
        button8.setImage(.monoSlime8, for: .normal)
        button9.setImage(.monoSlime9, for: .normal)
        
//        button1.contentMode = .scaleAspectFill
    }

    @IBAction func button1Tapped(_ sender: UIButton) {
//        label1.text = "행복해 " + String(Int.random(in: 1...100))
        values[0] += 1
        label1.text = "행복해 " + String(values[0])
    }
    @IBAction func button2Tapped(_ sender: UIButton) {
//        label2.text = "사랑해 " + String(Int.random(in: 1...100))
        values[1] += 1
        label2.text = "사랑해 " + String(values[1])
    }
    @IBAction func button3Tapped(_ sender: UIButton) {
//        label3.text = "좋아해 " + String(Int.random(in: 1...100))
        values[2] += 1
        label3.text = "좋아해 " + String(values[2])
    }
    @IBAction func button4Tapped(_ sender: UIButton) {
//        label4.text = "당황해 " + String(Int.random(in: 1...100))
        values[3] += 1
        label4.text = "당황해 " + String(values[3])
    }
    @IBAction func button5Tapped(_ sender: UIButton) {
//        label5.text = "속상해 " + String(Int.random(in: 1...100))
        values[4] += 1
        label5.text = "속상해 " + String(values[4])
    }
    @IBAction func button6Tapped(_ sender: UIButton) {
//        label6.text = "우울해 " + String(Int.random(in: 1...100))
        values[5] += 1
        label6.text = "우울해 " + String(values[5])

    }
    @IBAction func button7Tapped(_ sender: UIButton) {
//        label7.text = "심심해 " + String(Int.random(in: 1...100))
        values[6] += 1
        label7.text = "심심해 " + String(values[6])
    }
    @IBAction func button8Tapped(_ sender: UIButton) {
//        label8.text = "행복해 " + String(Int.random(in: 1...100))
        values[7] += 1
        label8.text = "행복해 " + String(values[7])
    }
    @IBAction func button9Tapped(_ sender: UIButton) {
//        label9.text = "행복해 " + String(Int.random(in: 1...100))
        values[8] += 1
        label9.text = "행복해 " + String(values[8])

    }
}

