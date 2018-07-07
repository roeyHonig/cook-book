//
//  customDraw6.swift
//  cook-book
//
//  Created by hackeru on 25 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
@IBDesignable
class customDraw6: UIView {
    
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 1
        UIColor.lightGray.setStroke()
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
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
