//
//  customDraw1.swift
//  cook-book
//
//  Created by hackeru on 24 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
@IBDesignable
class customDraw1: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 4
        UIColor.white.setStroke()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.stroke()
        
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
