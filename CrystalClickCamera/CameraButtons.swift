//
//  CameraButtons.swift
//  CrystalClickCamera
//
//  Created by Kyle Brooks Robinson on 6/13/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

@IBDesignable class MainButton: UIButton {
    
    @IBInspectable var cornerRadius: CGFloat = 10
    @IBInspectable var buttonColor: UIColor = UIColor.blueColor()
    @IBInspectable var lineThickness: CGFloat = 3
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        let insetRect = CGRectInset(rect, 10, 10)
        let path = UIBezierPath(roundedRect: rect, cornerRadius: cornerRadius)
        CGContextFillPath(context)
        let insetPath = UIBezierPath(roundedRect: insetRect, cornerRadius: cornerRadius)
        let insideColor = UIColor.whiteColor()
        
        buttonColor.set()
        
        CGContextAddPath(context, path.CGPath)
        CGContextFillPath(context)
        
        insideColor.set()
        
        CGContextSetLineWidth(context, lineThickness)
        CGContextAddPath(context, insetPath.CGPath)
        CGContextStrokePath(context)

    }
    
    
    
}

@IBDesignable class FlipButton: UIButton {
    
    @IBInspectable var buttonColor: UIColor = UIColor.blueColor()
    
    override func drawRect(rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        
        buttonColor.set()
        
        CGContextFillEllipseInRect(context, rect)
        
        
    }
    
}













