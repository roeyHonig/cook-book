//
//  CustomUIView7.swift
//  cook-book
//
//  Created by hackeru on 3 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class CustomUIView7: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 5
        path.lineCapStyle = CGLineCap.round
        UIColor.black.setStroke()
        path.move(to: CGPoint(x: rect.minX + 5, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX - 5, y: rect.midY))
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
