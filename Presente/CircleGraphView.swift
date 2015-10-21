//
//  CircleGraphView.swift
//  Presente
//
//  Created by Jenny Yang on 10/21/15.
//  Copyright © 2015 Evan Wineland. All rights reserved.
//

import UIKit

class CircleGraphView: UIView {
    
    var endArc:CGFloat = 0.0 {   // in range of 0.0 to 1.0
        didSet{
            setNeedsDisplay()
        }
    }
    var arcWidth:CGFloat = 10.0
    var arcColor = UIColor.yellowColor()
    var arcBackgroundColor = UIColor.blackColor()
    
    override func drawRect(rect: CGRect) {
        // Drawing code
        let fullCircle = 2.0 * CGFloat(M_PI)
        let start:CGFloat = -0.25 * fullCircle
        let end:CGFloat = endArc * fullCircle + start
        
        //find the centerpoint of the rect
        var centerPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMidY(rect))
        
        //define the radius by the smallest side of the view
        var radius:CGFloat = 0.0
        if CGRectGetWidth(rect) > CGRectGetHeight(rect){
            radius = (CGRectGetWidth(rect) - arcWidth) / 2.0
        }
        else {
            radius = (CGRectGetHeight(rect) - arcWidth) / 2.0
        }
        
        //starting point for all drawing code is getting the context.
        let context = UIGraphicsGetCurrentContext()
        
        //set line attributes
        CGContextSetLineWidth(context, arcWidth)
        
        //make the circle background
        CGContextSetStrokeColorWithColor(context, arcBackgroundColor.CGColor)
        CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, 0, fullCircle, 0)
        CGContextStrokePath(context)
        CGContextSetStrokeColorWithColor(context, arcColor.CGColor)
        CGContextSetLineWidth(context, arcWidth * 0.9)
        
        CGContextAddArc(context, centerPoint.x, centerPoint.y, radius, start, end, 0)
        CGContextStrokePath(context)
    }
    
}
