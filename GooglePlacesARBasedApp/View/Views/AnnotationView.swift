//
//  AnnotationView.swift
//  GooglePlacesARBasedApp
//
//  Created by Erkut Baş on 5/9/19.
//  Copyright © 2019 Erkut Baş. All rights reserved.
//

import UIKit

protocol AnnotationViewDelegate {
    func didTouch(annotationView: AnnotationView)
}

class AnnotationView: ARAnnotationView {
    
    lazy var topBarBadge: UIImageView = {
        let temp = UIImageView()
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.image = UIImage(named: "gradient_slider.png")
        temp.clipsToBounds = true
        
        return temp
    }()
    
    lazy var mainStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [topStackView, stackViewForStarIcons])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 10
        temp.alignment = .leading
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        temp.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        temp.isLayoutMarginsRelativeArrangement = true
        
        return temp
    }()
    
    lazy var topStackView: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [iconView, stackViewForLocationInfo])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 10
        temp.alignment = .fill
        temp.axis = .horizontal
        temp.distribution = .fill
        
        return temp
    }()
    
    let iconView: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
//        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.image = UIImage(named: "temp_icon.png")
        //temp.backgroundColor = #colorLiteral(red: 0, green: 0.7301091552, blue: 0.8039734364, alpha: 1)
        return temp
    }()
    
    lazy var stackViewForStarIcons: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [starImage1, starImage2, starImage3, starImage4, starImage5])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 8
        temp.alignment = .fill
        temp.axis = .horizontal
        temp.distribution = .fillEqually
        
        return temp
    }()
    
    let starImage1: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.image = UIImage(named: "star_icon_colored")?.withRenderingMode(.alwaysTemplate)
        temp.backgroundColor = UIColor.clear
        temp.tintColor = #colorLiteral(red: 1, green: 0.7108324766, blue: 0, alpha: 1)
        temp.tintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        return temp
    }()
    
    let starImage2: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.image = UIImage(named: "star_icon_colored")?.withRenderingMode(.alwaysTemplate)
        temp.backgroundColor = UIColor.clear
        temp.tintColor = #colorLiteral(red: 1, green: 0.7108324766, blue: 0, alpha: 1)
        temp.tintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        return temp
    }()
    
    let starImage3: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.image = UIImage(named: "star_icon_colored")?.withRenderingMode(.alwaysTemplate)
        temp.backgroundColor = UIColor.clear
        temp.tintColor = #colorLiteral(red: 1, green: 0.7108324766, blue: 0, alpha: 1)
        temp.tintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        return temp
    }()
    
    let starImage4: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.image = UIImage(named: "star_icon_colored")?.withRenderingMode(.alwaysTemplate)
        temp.backgroundColor = UIColor.clear
        temp.tintColor = #colorLiteral(red: 1, green: 0.7108324766, blue: 0, alpha: 1)
        temp.tintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        return temp
    }()
    
    let starImage5: UIImageView = {
        let temp = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.image = UIImage(named: "star_icon_colored")?.withRenderingMode(.alwaysTemplate)
        temp.backgroundColor = UIColor.clear
        temp.tintColor = #colorLiteral(red: 1, green: 0.7108324766, blue: 0, alpha: 1)
        temp.tintColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        return temp
    }()
    
    lazy var stackViewForLocationInfo: UIStackView = {
        
        let temp = UIStackView(arrangedSubviews: [locationName, distanceFromUser])
        temp.translatesAutoresizingMaskIntoConstraints = false
        temp.isUserInteractionEnabled = true
        temp.spacing = 2
        temp.alignment = .fill
        temp.axis = .vertical
        temp.distribution = .fillProportionally
        
        return temp
    }()
    
    let locationName: UILabel = {
        let label = UILabel()
        //label.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.text = LocalizedConstants.PermissionPrompts.locationName
        //label.font = UIFont(name: "Avenier-Medium", size: 48)
        label.font = UIFont(name: "Avenir-Medium", size: 16)
        label.textColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        label.setContentHuggingPriority(UILayoutPriority.init(rawValue: 249), for: NSLayoutConstraint.Axis.horizontal)
        
        return label
    }()
    
    let distanceFromUser: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = UIColor.lightGray
        label.numberOfLines = 0
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = LocalizedConstants.PermissionPrompts.distanceFromUser
        label.font = UIFont(name: "Avenir-Light", size: 12)
        label.textColor = #colorLiteral(red: 0.9999018312, green: 1, blue: 0.9998798966, alpha: 1)
        label.setContentHuggingPriority(UILayoutPriority.init(rawValue: 249), for: NSLayoutConstraint.Axis.horizontal)
        return label
    }()
    
    var delegate: AnnotationViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = #colorLiteral(red: 0.1647058824, green: 0.1803921569, blue: 0.262745098, alpha: 0.8)
        self.clipsToBounds = true
        
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        
        loadUserInterface()
    }
    
    private func loadUserInterface() {
        topBarBadge.removeFromSuperview()
        mainStackView.removeFromSuperview()
        
        self.addSubview(topBarBadge)
        self.addSubview(mainStackView)
        
        NSLayoutConstraint.activate([
            
            topBarBadge.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            topBarBadge.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            topBarBadge.topAnchor.constraint(equalTo: self.topAnchor),
            topBarBadge.heightAnchor.constraint(equalToConstant: 9),
            
            mainStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: self.topBarBadge.bottomAnchor, constant: 10),
            //mainStackView.heightAnchor.constraint(equalToConstant: 90),
            
            ])
        
        if let annotation = annotation as? Place {
            setPlacesDataToViews(annotation: annotation)
            
        }
        
    }
    
    private func setPlacesDataToViews(annotation: Place) {
        print("\(#function)")
        print("name : \(annotation.placeName)")
        locationName.text = annotation.placeName
        distanceFromUser.text = String(format: "%.2f km", annotation.distanceFromUser / 1000)
        
        guard let rating = annotation.rating else { return }

        let isInteger = floor(rating) == rating
        print("rating : \(rating)")
        print("isInteger : \(isInteger)")
        
        var counter = 0
        
        for item in stackViewForStarIcons.arrangedSubviews {
            if counter < Int(rating) {
                item.tintColor = #colorLiteral(red: 1, green: 0.7108324766, blue: 0, alpha: 1)
                counter += 1
            }
        }
        
        if !isInteger {
            let x = Int(rating)
            guard let a = stackViewForStarIcons.arrangedSubviews[x] as? UIImageView else { return }
            a.image = UIImage(named: "star_half_icon")
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        delegate?.didTouch(annotationView: self)
    }
}
