//
//  MapButtonViews.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 5/2/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class MapButtonViews: UIView {
    
    private var completionHandlerCameraButtonPressed : ((Bool) -> Void)?
    private var completionHandlerCurrentLocationButtonPressed : ((Bool) -> Void)?
    
    lazy var stackViewForProcessButtons: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [cameraButtonView])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 10
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    lazy var cameraButtonView: IconContainerView = {
        let temp = IconContainerView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), iconContainerViewProperty: IconContainerViewProperty(image: UIImage(named: "camera_icon.png")!, backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        temp.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.cameraButtonTapped)
        tapGesture.delegate = self
        temp.addGestureRecognizer(tapGesture)
        return temp
    }()
    
    lazy var currentLocationButtonView: IconContainerView = {
        let temp = IconContainerView(frame: CGRect(x: 0, y: 0, width: 50, height: 50), iconContainerViewProperty: IconContainerViewProperty(image: UIImage(named: "current_location_icon.png")!, backgroundColor: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
        temp.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: Selector.currentLocationTapped)
        tapGesture.delegate = self
        temp.addGestureRecognizer(tapGesture)
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewSettings()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - major functions
extension MapButtonViews {
    
    private func configureViewSettings() {
        
        self.addSubview(stackViewForProcessButtons)
        
        NSLayoutConstraint.activate([
            
            stackViewForProcessButtons.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackViewForProcessButtons.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackViewForProcessButtons.topAnchor.constraint(equalTo: self.topAnchor),
            stackViewForProcessButtons.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            ])
        
    }
    
    func listenCameraTapped(completion : @escaping(Bool) -> Void) {
        completionHandlerCameraButtonPressed = completion
    }
    
    func listenCurrentLocationTapped(completion : @escaping(Bool) -> Void) {
        completionHandlerCurrentLocationButtonPressed = completion
    }
    
}

// MARK: - UIGestureRecognizerDelegate
extension MapButtonViews: UIGestureRecognizerDelegate {
    
    // gesture functions
    @objc fileprivate func cameraButtonTapped(_ sender: UITapGestureRecognizer) {
        startAnimationCommon(inputObject: cameraButtonView)
        completionHandlerCameraButtonPressed?(true)
    }
    
    @objc fileprivate func currentLocationTapped(_ sender: UITapGestureRecognizer) {
        startAnimationCommon(inputObject: currentLocationButtonView)
        completionHandlerCurrentLocationButtonPressed?(true)
    }
    
    private func startAnimationCommon(inputObject: UIView) {
        
        inputObject.transform = CGAffineTransform(scaleX: 0.95, y: 0.95) // buton view kucultulur
        
        UIView.animate(withDuration: 1.0,
                       delay: 0,
                       usingSpringWithDamping: CGFloat(0.50),  // yay sonme orani, arttikca yanip sonme artar
            initialSpringVelocity: CGFloat(6.0),    // yay hizi, arttikca hizlanir
            options: UIView.AnimationOptions.allowUserInteraction,
            animations: {
                
                inputObject.transform = CGAffineTransform.identity
                
                
        })
        inputObject.layoutIfNeeded()
    }
    
}

fileprivate extension Selector {
    static let cameraButtonTapped = #selector(MapButtonViews.cameraButtonTapped)
    static let currentLocationTapped = #selector(MapButtonViews.currentLocationTapped)
}
