//
//  IconContainerView.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 5/2/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

struct IconContainerViewProperty {
    var image: UIImage
    var backgroundColor: UIColor
}

class IconContainerView: UIView {
    
    lazy var iconImageView: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        return temp
    }()
    
    init(frame: CGRect, iconContainerViewProperty: IconContainerViewProperty) {
        super.init(frame: frame)
        configureViewSettings(iconContainerViewProperty: iconContainerViewProperty)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - major functions
extension IconContainerView {
    
    fileprivate func addViews() {
        self.addSubview(iconImageView)
        
        NSLayoutConstraint.activate([
            
            iconImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            iconImageView.heightAnchor.constraint(equalToConstant: self.frame.height / 2),
            iconImageView.widthAnchor.constraint(equalToConstant: self.frame.height / 2),
            
            ])
    }
    
    fileprivate func setProperties(_ iconContainerViewProperty: IconContainerViewProperty) {
        self.iconImageView.image = iconContainerViewProperty.image
        self.backgroundColor = iconContainerViewProperty.backgroundColor
        
        self.layer.cornerRadius = 12
        
        self.layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 3
        self.layer.shadowOpacity = 0.5
        
    }
    
    private func configureViewSettings(iconContainerViewProperty: IconContainerViewProperty) {
        addViews()
        setProperties(iconContainerViewProperty)
        
    }
    
}
