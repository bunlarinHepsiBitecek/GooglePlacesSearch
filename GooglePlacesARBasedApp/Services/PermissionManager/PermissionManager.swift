//
//  PermissionManager.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/18/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import Foundation
import MapKit
import Photos

enum PermissionManagerResult {
    case success
    case fail
}

class PermissionManager: NSObject {
    
    public static var shared = PermissionManager()
    private var locationManager: CLLocationManager?
    
    override init() {
        super.init()
        locationManager = CLLocationManager()
        guard let locationManager = locationManager else { return }
        locationManager.delegate = self
    }
    
    var completionHandlerForLocationAuthorizationDidChange : ((PermissionButtonProperty) -> Void)?
    var completionHandlerPermissionsAcquired: ((Bool) -> Void)?
    
    /// Description : It's used to check the device has necessary permissions to move on
    ///
    /// - Parameter callerViewController: caller view controller to present permission view controller
    /// - Author: Erkut Bas
    func triggerPermissionCheck(callerViewController : UIViewController?) {
        print("\(#function) starts")
        
        if checkRequiredPermissionsExist() {
            // do nothing
        } else {
            let permissionViewController = PermissionViewController()
            permissionViewController.modalTransitionStyle = .crossDissolve
            guard let callerViewController = callerViewController else { return }
            callerViewController.present(permissionViewController, animated: true, completion: nil)
        }
        
    }
    
    
    /// Description : It's used to check required permissions exist or not
    ///
    /// - Returns: boolean value
    /// - Author: Erkut Bas
    func checkRequiredPermissionsExist() -> Bool {
        let cameraAccessStatus = AVCaptureDevice.authorizationStatus(for: .video)
        let locationAccessStatus = CLLocationManager.authorizationStatus()
        
        if cameraAccessStatus != .authorized || locationAccessStatus != .authorizedWhenInUse {
            return false
        } else {
            return true
        }
    }
    
    /// Description : It's create a permission button view and returns
    ///
    /// - Parameter permissionType: permission type, location or camera
    /// - Returns: PermissionButtonView
    /// - Author: Erkut Bas
    func createPermissionButtonView(permissionType : PermissionType) -> PermissionButtonView {
        return PermissionButtonView(frame: CGRect(x: 0, y: 0, width: 240, height: 50), permissionButtonProperty: returnPermissionProperty(permissionType: permissionType))
    }
    
    
    /// Description: It creates permission styles
    ///
    /// - Parameter permissionType: location or camera
    /// - Returns: permission property struct
    /// - Author: Erkut Bas
    func returnPermissionProperty(permissionType: PermissionType) -> PermissionButtonProperty {
        var permissionButtonProperty = PermissionButtonProperty(image: UIImage(), backgroundColor: #colorLiteral(red: 0.2274509804, green: 0.8, blue: 0.8823529412, alpha: 1), backgroundColorOfIconContainer: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), buttonPrompt: "", permissionResult: .authorized)
        
        switch permissionType {
        case .location:
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse, .authorizedAlways:
                permissionButtonProperty.backgroundColor = #colorLiteral(red: 0.2607704401, green: 0.3113521636, blue: 0.3954211175, alpha: 1)
                permissionButtonProperty.image = UIImage(named: "tick.png")!
                permissionButtonProperty.buttonPrompt = LocalizedConstants.PermissionPrompts.locationAccessed
                permissionButtonProperty.permissionResult = .authorized
                break
            case .denied, .restricted:
                permissionButtonProperty.image = UIImage(named: "corss_ar.png")!
                permissionButtonProperty.buttonPrompt = LocalizedConstants.PermissionPrompts.locationEnable
                permissionButtonProperty.backgroundColorOfIconContainer = #colorLiteral(red: 0.9698399901, green: 0.4038827121, blue: 0.4230939746, alpha: 1)
                permissionButtonProperty.permissionResult = .denied
                break
            case .notDetermined:
                permissionButtonProperty.image = UIImage(named: "placeholder_location.png")!
                permissionButtonProperty.buttonPrompt = LocalizedConstants.PermissionPrompts.locationRequest
                permissionButtonProperty.permissionResult = .notDetermined
                break
            @unknown default:
                fatalError()
            }
        case .camera:
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized:
                permissionButtonProperty.backgroundColor = #colorLiteral(red: 0.2607704401, green: 0.3113521636, blue: 0.3954211175, alpha: 1)
                permissionButtonProperty.image = UIImage(named: "tick.png")!
                permissionButtonProperty.buttonPrompt = LocalizedConstants.PermissionPrompts.cameraAccessed
                permissionButtonProperty.permissionResult = .authorized
                break
            case .denied, .restricted:
                permissionButtonProperty.image = UIImage(named: "corss_ar.png")!
                permissionButtonProperty.buttonPrompt = LocalizedConstants.PermissionPrompts.cameraEnable
                permissionButtonProperty.backgroundColorOfIconContainer = #colorLiteral(red: 0.9698399901, green: 0.4038827121, blue: 0.4230939746, alpha: 1)
                permissionButtonProperty.permissionResult = .denied
                break
            case .notDetermined:
                permissionButtonProperty.image = UIImage(named: "camera_ar.png")!
                permissionButtonProperty.buttonPrompt = LocalizedConstants.PermissionPrompts.cameraRequest
                permissionButtonProperty.permissionResult = .notDetermined
                break
            @unknown default:
                fatalError()
            }
        }
        
        return permissionButtonProperty
    }
    
    /// Description: request location or camera access permission
    ///
    /// - Parameters:
    ///   - permissionType: location or camera
    ///   - permissionResult: common permissin result such as authorized, denied etc
    func requestPermission(permissionType : PermissionType, permissionResult: PermissionResult) {
        
        print("check 1")
        
        if permissionResult == .denied {
            UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
        } else {
            switch permissionType {
            case .location:
                guard let locationManager = locationManager else { return }
                locationManager.requestWhenInUseAuthorization()
                print("check 2")
            case .camera:
                AVCaptureDevice.requestAccess(for: .video) { (granted) in
                    print("check 3")
                    if granted {
                        print("Camera granted")
                        if self.checkRequiredPermissionsExist() {
                            self.completionHandlerPermissionsAcquired?(true)
                        }
                    } else {
                        print("Camera not authorized")
                    }
                    self.completionHandlerForLocationAuthorizationDidChange?(self.returnPermissionProperty(permissionType: .camera))
                    
                }
            }
        }
        
    }
    
    
    /// Description: It's used to get current view controller in the foreground
    ///
    /// - Parameter rootViewController: ..
    /// - Returns: returns current view controller (toppest)
    /// - Author: Erkut Bas
    private func currentViewController(rootViewController: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        
        if let presentedViewController = rootViewController?.presentedViewController {
            return currentViewController(rootViewController: presentedViewController)
        }
        
        if let navigationController = rootViewController as? UINavigationController {
            return currentViewController(rootViewController: navigationController.visibleViewController)
        }
        
        if let tabBarController = rootViewController as? UITabBarController {
            if let selectedViewController = tabBarController.selectedViewController {
                return currentViewController(rootViewController: selectedViewController)
            }
        }
        
        return rootViewController
    }
    
}

// MARK: - CLLocationManagerDelegate
extension PermissionManager: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {

        print("didChangeAuthorization : \(status.rawValue)")
        
        // because rigth after locationManager initialized, this method is triggered. That's why we do not check notDetermind status
        if status != .notDetermined {
            
            print("TAKASI")
            completionHandlerForLocationAuthorizationDidChange?(returnPermissionProperty(permissionType: .location))
            if checkRequiredPermissionsExist() {
                completionHandlerPermissionsAcquired?(true)
            }
        }
        
    }
    
}
