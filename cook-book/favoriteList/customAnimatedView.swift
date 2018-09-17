//
//  customAnimatedView.swift
//  cook-book
//
//  Created by hackeru on 1 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class customAnimatedView: UIView {
    
    var toDraw = true
    
    
    
    override func draw(_ rect: CGRect) {
        if self.toDraw {
            
            UIView.animate(withDuration: 2, animations: {
                
                let path = UIBezierPath()
                path.lineWidth = 10
                UIColor.lightGray.setStroke()
                path.move(to: CGPoint(x: rect.minX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
                path.stroke()
                self.layoutIfNeeded()
            })
            
            self.toDraw = false
        } else {
            
            UIView.animate(withDuration: 2, animations: {
                let path = UIBezierPath()
                path.lineWidth = 10
                UIColor.clear.setStroke()
                path.move(to: CGPoint(x: rect.maxX, y: rect.midY))
                path.addLine(to: CGPoint(x: rect.minX, y: rect.midY))
                path.stroke()
                self.layoutIfNeeded()
            })
            
            
            self.toDraw = true
            
        }
    }

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
