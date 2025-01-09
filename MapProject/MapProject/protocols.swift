//
//  protocols.swift
//  MapProject
//
//  Created by 한수빈 on 1/8/25.
//

import UIKit
import MapKit


protocol Presentable: UIViewController {
    associatedtype Item
    var list: [Item] { get }
    var filteredList: [Item] { get set }
    
    func configureUI()
    
    func setupDelegate()
    
}

protocol MapProtocol: UIViewController {
    func setupMapView(mapView: MKMapView)
}

protocol ActionSheetProtocol: UIViewController {
    func simpleActionSheetSetUp(actions: [UIAlertAction]) -> UIAlertController
    func presentActionSheet()
}

extension ActionSheetProtocol {
    func simpleActionSheetSetUp(actions: [UIAlertAction]) -> UIAlertController {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        for action in actions {
            alertController.addAction(action)
        }

        return alertController
    }
}

//protocol U {
//    <#requirements#>
//}
