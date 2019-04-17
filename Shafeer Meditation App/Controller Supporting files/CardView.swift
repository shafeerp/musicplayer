//
//  CardView.swift
//  Shafeer Meditation App
//
//  Created by Shafeer Puthalan on 16/04/19.
//  Copyright © 2019 Shafeer Puthalan. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable class CardView : UIView {
    
    @IBInspectable var shadowColor : UIColor = UIColor.black
    @IBInspectable var cornerRadius : CGFloat = 0
    @IBInspectable var shadowOffSetWidth : Int = 0
    @IBInspectable var shadowOffSetHeight : Int = 0
    @IBInspectable var shadowOpacity : Float = 0.2
    
    override func layoutSubviews() {
        layer.cornerRadius = cornerRadius
        layer.shadowColor = shadowColor.cgColor
        layer.shadowOffset = CGSize(width: shadowOffSetWidth, height: shadowOffSetHeight)
        let shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius)
        layer.shadowPath = shadowPath.cgPath
        layer.shadowOpacity = shadowOpacity
    }
    
}
