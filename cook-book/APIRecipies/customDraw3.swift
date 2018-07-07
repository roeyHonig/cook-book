//
//  customDraw3.swift
//  cook-book
//
//  Created by hackeru on 24 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
@IBDesignable
class customDraw3: UIView {

    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 4
        UIColor.white.setStroke()
        path.move(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX * 0.5, y: rect.maxY))
        path.stroke()
        path.lineWidth = 2
        path.addLine(to: CGPoint(x: rect.minX, y: rect.minY))
        path.stroke()
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.stroke()
        path.addLine(to: CGPoint(x: rect.maxX * 0.5, y: rect.maxY))
        path.stroke()
        UIColor.white.setFill()
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
