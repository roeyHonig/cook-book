//
//  TrinagleUIView.swift
//  cook-book
//
//  Created by hackeru on 7 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class TrinagleUIView: UIView {
    var triHeight: CGFloat
    var parentView: UIView
    
    init(triHeight th: CGFloat, parentView pv: UIView) {
        self.triHeight = th
        self.parentView = pv
        super.init(frame: pv.frame) 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.lineWidth = 2
        let uiColor = UIColor(red: 46.0/255.0, green: 44.0/255.0, blue: 171.0/255.0, alpha: 1) //UIColor requires a float from 0 - 1, not from 0 - 255
        uiColor.setStroke()
        uiColor.setFill()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
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
