//
//  ScribbleView.swift
//  CrystalClickCamera
//
//  Created by Kyle Brooks Robinson on 6/13/15.
//  Copyright (c) 2015 Kyle Brooks Robinson. All rights reserved.
//

import UIKit

var publicSliderSetting = 0.0


class ScribbleView: UIView {

    var scribbles: [Scribble] = []
    var currentColor: UIColor = UIColor.blackColor()
    
    override func drawRect(rect: CGRect) {
        
        var context = UIGraphicsGetCurrentContext()
        
        CGContextSetLineWidth(context, CGFloat(2.0))
        CGContextSetLineCap(context, kCGLineCapRound)
        
        for scribble in scribbles {
            
            if let firstPoint = scribble.points.first {
                
                CGContextMoveToPoint(context, firstPoint.x, firstPoint.y)
                
                for point in scribble.points {
                    
                    CGContextSetLineWidth(context, CGFloat(scribble.strokeSize))
                    CGContextAddLineToPoint(context, point.x, point.y)
                    
                }
                
                CGContextStrokePath(context)
                
            }
            
        }
        
        
    }
    
    func newScribbleWithStartPoint(point: CGPoint) {
        
        var scribble = Scribble()
        scribble.points = [point, point]
        
        scribble.strokeSize = publicSliderSetting
        
        scribbles.append(scribble)
        setNeedsDisplay()
        
        
    }
    
    func updateCurrentScribbleWithLastPoint(point: CGPoint) {
        
        if scribbles.last != nil {
            
            scribbles[scribbles.count - 1].points[1] = point
            
            setNeedsDisplay()
            
        }
        
        
    }
    

}

class Scribble {
    
    var points: [CGPoint] = []
    var strokeColor: UIColor?
    var strokeSize: Double = 2.0
    
    
    
}