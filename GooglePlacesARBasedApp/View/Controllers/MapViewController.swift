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
    
    private var mapviewControllerViewModel = MapViewControllerViewModel()
    private var arViewController: ARViewController!
    
    lazy var mapView: MapView = {
        let temp = MapView(frame: .zero)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        return temp
    }()
    
    lazy var tempButton: UIButton = {
        let temp = UIButton(type: .system)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.setTitle("Lhmc", for: .normal)
        
        temp.addTarget(self, action: Selector.testSearch, for: .touchUpInside)
        
        temp.layer.cornerRadius = 12
        
        temp.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        temp.layer.shadowOffset = CGSize(width: 0, height: 2)
        temp.layer.shadowRadius = 3
        temp.layer.shadowOpacity = 0.5
        
        return temp
    }()
    
    lazy var tempButton2: UIButton = {
        let temp = UIButton(type: .system)
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        temp.setTitle("ATM", for: .normal)
        
        temp.addTarget(self, action: Selector.testSearch2, for: .touchUpInside)
        
        temp.layer.cornerRadius = 12
        
        temp.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        temp.layer.shadowOffset = CGSize(width: 0, height: 2)
        temp.layer.shadowRadius = 3
        temp.layer.shadowOpacity = 0.5
        
        return temp
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        prepareViewControllerSettings()
        listenForegroundProcess()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("MapViewController didAppear")
        PermissionManager.shared.triggerPermissionCheck(callerViewController: self)
        
        PermissionManager.shared.completionHandlerPermissionsAcquired = { (granted) -> Void in
            print("granted : \(granted)")
            
        }
        
    }
    
    deinit {
        mapviewControllerViewModel.googleApiResult.unbind()
        mapviewControllerViewModel.googleSearchResultData.unbind()
    }
    
    @objc func testSearch(_ sender : UIButton) {
        startSearchPlaceProcess(apiCallData: GoogleApiCallStruct(callType: .searchByKeyword, keyword: "Lahmacun"))
    }
    
    @objc func testSearch2(_ sender : UIButton) {
        startSearchPlaceProcess(apiCallData: GoogleApiCallStruct(callType: .searchByTpye, keyword: "atm"))
        
    }
    
    private func startSearchPlaceProcess(apiCallData: GoogleApiCallStruct) {
        mapviewControllerViewModel.getDataFromGooglePlacesApi(apiCallData: apiCallData)
    }
    
}

// MARK: - major functions
extension MapViewController {
    
    private func prepareViewControllerSettings() {
        changeBackgroundcolor()
        addMapView()
        addMapViewButtonsListener()
        addViewModelListeners()
        
        self.view.addSubview(tempButton)
        self.view.addSubview(tempButton2)
        
        NSLayoutConstraint.activate([
            
            tempButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            tempButton.bottomAnchor.constraint(equalTo: self.mapView.trackingButtonContainer.topAnchor, constant: -10),
            tempButton.heightAnchor.constraint(equalToConstant: 50),
            tempButton.widthAnchor.constraint(equalToConstant: 50),
            
            tempButton2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -15),
            tempButton2.bottomAnchor.constraint(equalTo: self.tempButton.topAnchor, constant: -10),
            tempButton2.heightAnchor.constraint(equalToConstant: 50),
            tempButton2.widthAnchor.constraint(equalToConstant: 50),
            
            ])
        
    }
    
    fileprivate func updateMapviewAnnotations(_ googleResultData: [GoogleSearchResult]) {
        print("google result data retrieved")
        DispatchQueue.main.async {
            self.mapView.addAnnotation(googleSearchResultData: googleResultData)
        }
    }
    
    private func addViewModelListeners() {
        mapviewControllerViewModel.googleApiResult.bind { (status) in
            print("status : \(status)")
        }
        
        mapviewControllerViewModel.googleSearchResultData.bind { (googleResultData) in
            self.updateMapviewAnnotations(googleResultData)
        }
    }
    
    fileprivate func listenForegroundProcess() {
        let notificationCenter =  NotificationCenter.default
        notificationCenter.addObserver(self, selector: Selector.detectForeground, name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
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
    
    @objc func detectForeground() {
        print("\(#function)")
        PermissionManager.shared.triggerPermissionCheck(callerViewController: self)
    }
    
    private func addMapViewButtonsListener() {
        mapView.listenCamereButtonTapped { (tapped) in
            if tapped {
                print("camera tapped")
                
                self.triggerARViewController()
                
            }
        }
        
        mapView.listenCurrentLocationButtonTapped { (tapped) in
            if tapped {
                print("current location tapped")
            }
        }
    }
    
    private func triggerARViewController() {
        arViewController = ARViewController()
        arViewController.dataSource = self
        arViewController.maxDistance = 0
        arViewController.maxVisibleAnnotations = 30
        arViewController.maxVerticalLevel = 5
        arViewController.headingSmoothingFactor = 0.05
        
        arViewController.trackingManager.userDistanceFilter = 25
        arViewController.trackingManager.reloadDistanceFilter = 75
        arViewController.setAnnotations(mapviewControllerViewModel.returnPlacesAnnotationData())
        arViewController.uiOptions.debugEnabled = false
        arViewController.uiOptions.closeButtonEnabled = true
        
        self.present(arViewController, animated: true, completion: nil)
    }

}

// MARK: - ARDataSource
extension MapViewController: ARDataSource {
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        let annotationView = AnnotationView(frame: CGRect(x: 0, y: 0, width: 180, height: 100))
        annotationView.annotation = viewForAnnotation
        annotationView.delegate = self
//        annotationView.frame = CGRect(x: 0, y: 0, width: 180, height: 100)
        annotationView.layer.cornerRadius = 12
        annotationView.clipsToBounds = true
        
        return annotationView
    }
}

// MARK: - AnnotationViewDelegate
extension MapViewController: AnnotationViewDelegate {
    func didTouch(annotationView: AnnotationView) {
        print("\(#function)")
    }
    
    
}

// MARK: - Selector
fileprivate extension Selector {
    static let detectForeground = #selector(MapViewController.detectForeground)
    static let testSearch = #selector(MapViewController.testSearch)
    static let testSearch2 = #selector(MapViewController.testSearch2)
}

