//
//  CustomUIView7.swift
//  cook-book
//
//  Created by hackeru on 3 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
import CoreData

class CustomUIView7: UIView {
   
    var numOfVerticalSections: Int = 0
    
    override func draw(_ rect: CGRect) {
        guard numOfVerticalSections > 0 else {
            return
        }
        for i in 1...numOfVerticalSections {
            let path = UIBezierPath()
            path.lineWidth = 5
            path.lineCapStyle = CGLineCap.round
            UIColor.black.setStroke()
            let rec = CGRect(x: rect.minX, y: CGFloat(Float(i - 1)) * (rect.height / CGFloat(Float(numOfVerticalSections))), width: rect.width, height: rect.height / CGFloat(Float(numOfVerticalSections)))
            path.move(to: CGPoint(x: rec.minX + 5, y: rec.midY))
            path.addLine(to: CGPoint(x: rec.maxX - 5, y: rec.midY))
            path.stroke()
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
