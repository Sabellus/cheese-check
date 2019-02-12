//
//  DesignableView.swift
//  Cheese
//
//  Created by Савелий Вепрев on 17/01/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit

@IBDesignable
class DesignableView: UIView {
    
        @IBInspectable var startColor: UIColor = .black
        @IBInspectable var endColor:   UIColor = .white
        @IBInspectable var startLocation: Double = 0.05
        @IBInspectable var endLocation:   Double = 0.95
        @IBInspectable var horizontalMode: Bool = false
        @IBInspectable var diagonalMode: Bool = false
        
        // add border color, width and corner radius properties to your GradientView
        @IBInspectable var cornerRadius: CGFloat = 0
        @IBInspectable var borderColor: UIColor = .clear
        @IBInspectable var borderWidth: CGFloat = 0
        
        override class var layerClass: AnyClass { return CAGradientLayer.self }
        var gradientLayer: CAGradientLayer { return layer as! CAGradientLayer }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            if horizontalMode {
                gradientLayer.startPoint = diagonalMode ? CGPoint(x: 1, y: 0) : CGPoint(x: 0, y: 0.5)
                gradientLayer.endPoint   = diagonalMode ? CGPoint(x: 0, y: 1) : CGPoint(x: 1, y: 0.5)
            } else {
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
                gradientLayer.endPoint = CGPoint(x: 1.0,y: 0.5)
            }
            gradientLayer.locations = [startLocation as NSNumber,  endLocation  as NSNumber]
            gradientLayer.colors    = [startColor.cgColor, endColor.cgColor]
            
            // add border and corner radius also to your layer
            gradientLayer.cornerRadius = cornerRadius
            gradientLayer.borderColor = borderColor.cgColor
            gradientLayer.borderWidth = borderWidth
        }
    
    
    
}

