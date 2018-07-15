//
//  CustomUIView9.swift
//  cook-book
//
//  Created by hackeru on 3 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
import CoreData

class CustomUIView9: UIView {
    
    var numOfVerticalSections: Int
    var currentNumOfVerticalSections: Int
    var parentUIView: UIView
    
    init(currentNumOfVerticalSections i: Int, outOfTotalNumOfVerticalSections num: Int, toBeSubViewdIn view: UIView ) {
        currentNumOfVerticalSections = i
        numOfVerticalSections = num
        parentUIView = view
        super.init(frame: parentUIView.frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        guard numOfVerticalSections > 0 else {
            return
        }
       
        let path = UIBezierPath()
        path.lineWidth = 5
        path.lineCapStyle = CGLineCap.round
        UIColor.lightGray.setStroke()
        let rec = CGRect(x: rect.minX, y: CGFloat(Float(currentNumOfVerticalSections - 1)) * (rect.height / CGFloat(Float(numOfVerticalSections))), width: rect.width, height: rect.height / CGFloat(Float(numOfVerticalSections)))
        path.move(to: CGPoint(x: rec.minX + 5, y: rec.midY))
        path.addLine(to: CGPoint(x: rec.maxX - 5, y: rec.midY))
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
