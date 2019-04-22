//
//  MapView.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/22/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit
import MapKit

class MapView: UIView {
    
    private var mapViewModel = MapViewModel()

    lazy var mapView: MKMapView = {
        let temp = MKMapView(frame: .zero)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.showsScale = true
        temp.showsCompass = true
        temp.showsUserLocation = true
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureViewSetttings()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - major functions
extension MapView {
    
    private func configureViewSetttings() {
        self.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: self.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ])
    }
    
}

// MARK: - MKMapViewDelegate
extension MapView: MKMapViewDelegate {

    
    
}
