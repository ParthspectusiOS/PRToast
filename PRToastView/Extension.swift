//
//  Extension.swift
//  PodTest
//
//  Created by Spectus Infotech on 21/07/23.
//

import Foundation
import UIKit


extension UIView {
    
    func makeRoundedCornerWith(_ radius : CGFloat) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = true
    }
    func setCornerRadiusWithShadow(_ radius: CGFloat, shadowOpacity: Float, shadowColor : UIColor, shadowOffset : CGSize,shadowRadius:CGFloat) {
        
        
        DispatchQueue.main.async {
            self.makeRoundedCornerWith(radius)
            self.applyShadow(shadowOpacity: shadowOpacity, shadowColor: shadowColor, shadowOffset: shadowOffset,shadowRadius: shadowRadius)
        }
    }
    func applyShadow(shadowOpacity: Float, shadowColor : UIColor, shadowOffset : CGSize, shadowRadius : CGFloat? = nil) {
        DispatchQueue.main.async {
            self.layer.shadowColor = shadowColor.cgColor
            self.layer.shadowOffset = shadowOffset
            self.layer.shadowOpacity = shadowOpacity
            self.layer.masksToBounds = false
            self.layer.shadowRadius = shadowRadius ?? self.layer.cornerRadius
        }
    }
    
    func GradientView(Direction : GradientDirection, Colors : [CGColor],cornerRadius:CGFloat? = nil){
               
        DispatchQueue.main.async {
            self.layer.masksToBounds = false
            let gradientLayer = CAGradientLayer()
            gradientLayer.colors = Colors
            gradientLayer.cornerRadius = cornerRadius ?? self.layer.cornerRadius
            if Direction == .Horizontal {
                gradientLayer.startPoint = CGPoint(x: 0, y: 0)
                gradientLayer.endPoint = CGPoint(x: 1, y: 0)
            }else{
                gradientLayer.startPoint = CGPoint(x: 0, y: 1)
                gradientLayer.endPoint = CGPoint(x: 0, y: 0)
            }
            gradientLayer.frame = self.bounds
            self.layer.insertSublayer(gradientLayer, at:0)
        }
    }
}


