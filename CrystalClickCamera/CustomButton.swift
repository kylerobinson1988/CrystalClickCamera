//
//  CustomButton.swift
//  CrystalClickCamera
//
//  Created by Kyle Brooks Robinson on 7/2/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

@IBDesignable class CustomButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var buttonColor: UIColor = UIColor.blackColor()
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        buttonColor.set()

        CGContextAddPath(context, path.CGPath)
        CGContextFillPath(context)
        
    }

}
