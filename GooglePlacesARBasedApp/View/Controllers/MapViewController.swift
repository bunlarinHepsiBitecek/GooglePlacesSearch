//
//  MapViewController.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/22/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    lazy var mapView: MapView = {
        let temp = MapView(frame: .zero)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareViewControllerSettings()
        
        
        
//        LocationManager.shared.getChangeLocationData { (location) in
//            print("Yarro Location : \(location)")
//        }
//
//        LocationManager.shared.startUpdateLocation()
//
//        LocationManager.shared.locationCompletionHandler = { (dataReturned) -> Void in
//            print("data returned : \(dataReturned)")
//
//        }
        
        let notificationCenter =  NotificationCenter.default
        notificationCenter.addObserver(self, selector: Selector.detectForeground, name: UIApplication.willEnterForegroundNotification, object: nil)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("MapViewController didAppear")
        PermissionManager.shared.triggerPermissionCheck(callerViewController: self)
    }
    
}

// MARK: - major functions
extension MapViewController {
    
    fileprivate func changeBackgroundcolor() {
        self.view.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
    }
    
    fileprivate func addMapView() {
        self.view.addSubview(mapView)
        
        let safe = self.view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            
            mapView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: self.view.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: safe.bottomAnchor),
            
            ])
    }
    
    private func prepareViewControllerSettings() {
        changeBackgroundcolor()
        addMapView()
        
    }
    
    @objc func detectForeground() {
        print("\(#function)")
        PermissionManager.shared.triggerPermissionCheck(callerViewController: self)
    }
    
}

fileprivate extension Selector {
    static let detectForeground = #selector(MapViewController.detectForeground)
}
