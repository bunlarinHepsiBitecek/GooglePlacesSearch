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
    
    private var tempGoogleSearchResult = [GoogleSearchResult]()
    
    private var mapViewModel = MapViewModel()
    
    private var zoom: CLLocationDegrees = CONSTANT.MAP_KIT_CONSTANT.ZOOM_DEGREE_0_005

    private var counter = 1
    
    lazy var mapView: MKMapView = {
        let temp = MKMapView(frame: .zero)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.showsScale = true
        temp.showsCompass = true
        temp.showsUserLocation = true
        //temp.setUserTrackingMode(.followWithHeading, animated: true)
        temp.delegate = self
        
        temp.register(GoogleSearchResultMarkerAnnotationView.self, forAnnotationViewWithReuseIdentifier: GoogleSearchResultMarkerAnnotationView.identifier)
        
        return temp
    }()
    
    lazy var mapButtons: MapButtonViews = {
        let temp = MapButtonViews()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        return temp
    }()
    
    lazy var trackingButtonContainer: UIView = {
        let temp = UIView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        temp.layer.cornerRadius = 12
        
        temp.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        temp.layer.shadowOffset = CGSize(width: 0, height: 2)
        temp.layer.shadowRadius = 3
        temp.layer.shadowOpacity = 0.5
        
        return temp
    }()
    
    var coordinate: CLLocationCoordinate2D? {
        didSet {
            if let coordinate = coordinate {
                centerMap(coordinate: coordinate)
            }
        }
    }
    
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
        addMapView()
        addMapButtons()
        addTrackingButton()
        arrangeMapZoomRateAfterLoaded()
        
    }
    
    fileprivate func addMapView() {
        self.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            
            mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mapView.topAnchor.constraint(equalTo: self.topAnchor),
            mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ])
    }
    
    fileprivate func addTrackingButton() {
        
        let userTrackingButton = MKUserTrackingButton(mapView: mapView)
        userTrackingButton.translatesAutoresizingMaskIntoConstraints = false
        userTrackingButton.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        userTrackingButton.layer.cornerRadius = 12
        
        self.mapView.addSubview(trackingButtonContainer)
        self.trackingButtonContainer.addSubview(userTrackingButton)
        
        userTrackingButton.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            
            trackingButtonContainer.trailingAnchor.constraint(equalTo: self.mapView.trailingAnchor, constant: -15),
            trackingButtonContainer.bottomAnchor.constraint(equalTo: self.mapButtons.topAnchor, constant: -10),
            trackingButtonContainer.heightAnchor.constraint(equalToConstant: 50),
            trackingButtonContainer.widthAnchor.constraint(equalToConstant: 50),
            
            userTrackingButton.leadingAnchor.constraint(equalTo: self.trackingButtonContainer.leadingAnchor),
            userTrackingButton.trailingAnchor.constraint(equalTo: self.trackingButtonContainer.trailingAnchor),
            userTrackingButton.topAnchor.constraint(equalTo: self.trackingButtonContainer.topAnchor),
            userTrackingButton.bottomAnchor.constraint(equalTo: self.trackingButtonContainer.bottomAnchor),
            
            ])
    }
    
    fileprivate func addMapButtons() {
        self.mapView.addSubview(mapButtons)
        
        NSLayoutConstraint.activate([
            
            mapButtons.trailingAnchor.constraint(equalTo: self.mapView.trailingAnchor, constant: -15),
            mapButtons.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: -100),
            mapButtons.heightAnchor.constraint(equalToConstant: 50),
            mapButtons.widthAnchor.constraint(equalToConstant:  50)
            
            ])
    }
    
    private func arrangeMapZoomRateAfterLoaded() {
        LocationManager.shared.getCurrentLocationData { (location) in
            
            self.mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: CONSTANT.MAP_KIT_CONSTANT.ZOOM_DEGREE_0_025, longitudeDelta: CONSTANT.MAP_KIT_CONSTANT.ZOOM_DEGREE_0_025)), animated: true)
            
        }
    }
    
    private func centerMap(coordinate : CLLocationCoordinate2D) {
        
        print("centerMap starts")
        print("coordinate : \(coordinate)")
        
        let span = MKCoordinateSpan.init(latitudeDelta: zoom, longitudeDelta: zoom)
        //        let span = MKCoordinateSpanMake(coordinate.latitude, coordinate.longitude)
        let region = MKCoordinateRegion.init(center: coordinate, span: span)
        
        mapView.setRegion(region, animated: true)
        
    }
    
    @objc func textSearchDeneme(_ sender: UIButton) {
        print("\(#function)")
        
        
        
    }
    
}

// MARK: - outside callers
extension MapView {
    
    func setCoordinate(location: CLLocation) {
        print("\(#function)")
        centerMap(coordinate: location.coordinate)
    }
    
    func listenCamereButtonTapped(completion: @escaping (Bool) -> Void) {
        mapButtons.listenCameraTapped(completion: completion)
    }
    
    func listenCurrentLocationButtonTapped(completion: @escaping (Bool) -> Void) {
        mapButtons.listenCurrentLocationTapped(completion: completion)
    }
    
    private func removeAnnotationsOnMap() {
        for annotation in mapView.annotations {
            if !(annotation is MKUserLocation) {
                mapView.removeAnnotation(annotation)
            }
        }
    }
    
    func addAnnotation(googleSearchResultData: [GoogleSearchResult]) {
        // first remove all other annotations
        removeAnnotationsOnMap()
        
        var annotationArray = [MKAnnotation]()
        
        for item in googleSearchResultData {
            let annotation = GoogleSearchResultAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.geometry.location.lat, longitude: item.geometry.location.lng), title: item.name)
            
            self.mapView.addAnnotation(annotation)
            
            //annotationArray.append(annotation)
        }
        
        //self.mapView.showAnnotations(annotationArray, animated: true)
    }
    
//    GoogleSearchResultAnnotation(coordinate: CLLocationCoordinate2D(latitude: item.geometry.location.lat, longitude: item.geometry.location.lng), title: item.name)
//                                self.mapView.addAnnotation(temp)
//
//                            }

}

// MARK: - MKMapViewDelegate
extension MapView: MKMapViewDelegate {
    
    func mapViewDidFinishLoadingMap(_ mapView: MKMapView) {
        // it causes constant current location zoom
        //mapView.setUserTrackingMode(.followWithHeading, animated: true)
        print("\(#function)")
        
        /*
        LocationManager.shared.getCurrentLocationData { (location) in
            
            mapView.setRegion(MKCoordinateRegion(center: location.coordinate, span: MKCoordinateSpan(latitudeDelta: CONSTANT.MAP_KIT_CONSTANT.ZOOM_DEGREE_0_025, longitudeDelta: CONSTANT.MAP_KIT_CONSTANT.ZOOM_DEGREE_0_025)), animated: true)
            
        }*/
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        guard !annotation.isKind(of: MKUserLocation.self) else {
            // Make a fast exit if the annotation is the `MKUserLocation`, as it's not an annotation view we wish to customize.
            return nil
        }
        
        guard let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: GoogleSearchResultMarkerAnnotationView.identifier) as? GoogleSearchResultMarkerAnnotationView else { return nil }
        
        return annotationView
        
    }

//    // user tracking mode and didupdate functions can not run together
//    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
//        print("userlocation : \(userLocation)")
//
//        //mapView.centerCoordinate = userLocation.coordinate
////        let span = MKCoordinateSpan.init(latitudeDelta: zoom, longitudeDelta: zoom)
////        let region = MKCoordinateRegion.init(center: userLocation.coordinate, span: span)
////        mapView.setRegion(region, animated: true)
//
//    }
    
}
    
// MARK: - Selector
fileprivate extension Selector {
    static let testSearch = #selector(MapView.textSearchDeneme)
}


