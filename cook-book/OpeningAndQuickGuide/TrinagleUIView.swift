//
//  TrinagleUIView.swift
//  cook-book
//
//  Created by hackeru on 7 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//
// creates a filled trinagle with a height between 0-1 of the original parent UIView Height with the specified RGB (values are also 0-1 not 0-255) and an alpha of 1

import UIKit

class TrinagleUIView: UIView {
    var triHeight: CGFloat
    var parentView: UIView
    //var red: Float
    //var green: Float
    //var blue: Float
    var viewAlpha: CGFloat
    var flameColor: UIColor
    var skewAngle: Double
    var scaleX: CGFloat
    var scaleY: CGFloat
    
    /*
    init(triHeight th: CGFloat, parentView pv: UIView,red r: Float, green g: Float, blue b: Float, viewAlpha va: CGFloat) {
        
        self.triHeight = th
        self.parentView = pv
        self.red = r
        self.green = g
        self.blue = b
        self.viewAlpha = va
        super.init(frame: pv.frame)
        self.alpha = va
        //self.backgroundColor = UIColor.clear
    }
    */
    
    init(triHeight th: CGFloat, parentView pv: UIView,uiColor uic: UIColor, viewAlpha va: CGFloat, skewAngle sa: Double, scaleX sx: CGFloat, scaleY sy: CGFloat) {
        
        self.triHeight = th
        self.parentView = pv
        self.flameColor = uic
        self.viewAlpha = va
        self.skewAngle = sa
        self.scaleX = sx
        self.scaleY = sy
        super.init(frame: pv.frame)
        self.alpha = va
        self.backgroundColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 2
        let uiColor = flameColor
        uiColor.setStroke()
        uiColor.setFill()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY - triHeight * rect.height ))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.close()
        path.stroke()
        path.fill()
        
        
    }
    
   
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
