//
//  MapViewController.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 4/22/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        prepareViewControllerSettings()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - major functions
extension MapViewController {
    
    private func prepareViewControllerSettings() {
        self.view.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 1)
        // 262440
    }
    
}
