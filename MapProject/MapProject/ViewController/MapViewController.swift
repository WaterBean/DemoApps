//
//  MapViewController.swift
//  MapProject
//
//  Created by 한수빈 on 1/8/25.
//

import UIKit
import MapKit

final class MapViewController: UIViewController, Presentable, MapProtocol, ActionSheetProtocol {
    
    private(set) var list: [Restaurant] = RestaurantList().restaurantArray
    
    lazy var filteredList: [Restaurant] = list {
        didSet {
            var annotationArray: [MKPointAnnotation] = []
            for i in filteredList {
                let annotation = MKPointAnnotation()
                annotation.coordinate = i.coordinate
                annotation.title = i.name
                annotationArray.append(annotation)
            }
            annotations = annotationArray
            print(filteredList.count)
        }
    }
    lazy var annotations: [MKPointAnnotation] = [] {
        didSet {
            mapView.removeAnnotations(oldValue)
            updateAnnotation()
        }

    }
    
    @IBOutlet var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        setupDelegate()
        setupMapView(mapView: mapView)
        
        filterByRestaurantType(type: RestaurantType.all.rawValue)
    }
    
    func configureUI() {
        let rightBarButtonItem = UIBarButtonItem(title: "Filter", style: .plain, target: self, action: #selector(presentActionSheet))
        navigationItem.rightBarButtonItem = rightBarButtonItem
    }
    
    func setupDelegate() {
        mapView.delegate = self
    }
    
    func setupMapView(mapView: MKMapView) {
        let center = CLLocationCoordinate2D(latitude: 37.6533675, longitude: 127.0477088)
        mapView.setRegion(MKCoordinateRegion(center: center, latitudinalMeters: 500, longitudinalMeters: 500), animated: true)
        
        updateAnnotation()
    }
    
    @objc func presentActionSheet() {
        let alertController = simpleActionSheetSetUp(actions: createAlertActionByType())
        
        present(alertController, animated: true)
    }
    
    func createAlertActionByType() -> [UIAlertAction] {
        return RestaurantType.allCases.map { type in
            UIAlertAction(title: type.getString, style: .default) { [unowned self] _ in
                filterByRestaurantType(type: type.rawValue)
            }
        }
    }
    
    func filterByRestaurantType(type: Int) {
        if type == RestaurantType.all.rawValue {
            filteredList = list
        } else {
            filteredList = list.filter { $0.type == type }
        }
    }
    
    func updateAnnotation() {
        mapView.addAnnotations(annotations)
    }
    
}

extension MapViewController: MKMapViewDelegate {
    
}

enum RestaurantType: Int, CaseIterable {
    case all = 0
    case snack = 100
    case cafe = 200
    case asian = 300
    case western = 400
    
    
    var getString: String {
        get {
            switch self.rawValue {
            case 100: "분식"
            case 200: "카페"
            case 300: "아시안"
            case 400: "양식"
            default: "모두 선택"
            }
            
        }
    }


}


