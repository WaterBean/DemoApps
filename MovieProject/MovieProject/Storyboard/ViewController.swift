//
//  ViewController.swift
//  MovieProject
//
//  Created by 한수빈 on 12/24/24.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}


// MARK: - Storyboard Inspectable Properties

extension UIView {
    @IBInspectable var borderColor: UIColor {
        get {
            let color = self.layer.borderColor ?? UIColor.clear.cgColor
            return UIColor(cgColor: color)
        }
        
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }

    @IBInspectable var borderWidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        
        set {
            self.layer.borderWidth = newValue
        }
    }

    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        
        set {
            self.layer.cornerRadius = newValue
        }
    }
}

/*
 # 과제 1. Entry Point

 ## Entry Point가 무엇이며, 왜 필요할까요?

 앱이 실행되고 launch screen이 실행되고 나서 첫 번째로 진입하는 ViewController를 가리키는 Point. 즉, '진입점'이다.
 ![[Pasted image 20241224190343.png]]
 - 앱이 실행되고 진입해야하는 화면을 지정해줘야하기 때문이다.

 ## Entry Point가 없으면 어떻게 될까요?

 - 진입할 곳이 없기에 앱이 실행되었을 때 검은 화면으로 나오며, 사실상 앱을 사용할 수 없다.

 ## Entry Point 삭제 후 디버그 영역을 확인하고, 앱이 다시 정상적으로 동작할 수 있도록 Entry Point를 지정해보세요.
 - 콘솔 메시지 `Failed to instantiate the default view controller for UIMainStoryboardFile 'Main' - perhaps the designated entry point is not set?` -> "Main 스토리보드파일 안에 있는 default viewcontroller를 인스턴스화 시키는 것을 실패했음 - 아마도 지정된 진입점이 설정되지 않았을거다 "
 - 스토리보드에서 진입할 ViewController를 선택후 오른쪽 패널(Attribute inspector)에서 `is initial View Controller`를 체크해 entry point를 삽입할 수 있다. 화살표를 드래그해서 진입점을 변경할 수 있다.
 */
