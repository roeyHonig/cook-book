//
//  favoriteRecipesViewController.swift
//  cook-book
//
//  Created by hackeru on 16 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//  currentlly just an example for loading url image

import UIKit
import SDWebImage

class favoriteRecipesViewController: UIViewController, CAAnimationDelegate {
    
    var isDrawingNow = false
    let layer = CAShapeLayer()
    var toCross = true
    @IBOutlet var animatedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
        // prepre the path
       
        
        
        // Create shape layer and add the path to it
        
        
        
        let tapGesture = UITapGestureRecognizer()
        tapGesture.addTarget(self, action: #selector(toggleCrossStatus))
        animatedView.addGestureRecognizer(tapGesture)
        
    }

    @objc func toggleCrossStatus(){
        if !self.isDrawingNow{
            self.animateCrossPath()
        }
        
    }
    
    func animateCrossPath() {
        self.isDrawingNow = true
        // prepre the path
        let path = UIBezierPath()
        
    
        // draw the line from right to left
        let rect = animatedView.frame
        let newx = rect.midX
        let newy = rect.midY
        
        let origx = newx - ((rect.size.width * 0.8) / 2)
        let origy = newy - ((rect.size.height * 0.8) / 2)
        let cgpoint = CGPoint(x: origx, y: origy)
        let newSize = CGSize(width: rect.size.width * 0.8, height: rect.size.height * 0.8)
        let rec = CGRect(origin: cgpoint, size: newSize)
        
        path.move(to: CGPoint(x: rec.minX , y: rec.midY))
        path.addLine(to: CGPoint(x: rec.maxX, y: rec.midY))
        
        layer.path = path.cgPath
        
        // Set up the appearance of the shape layer
        
        layer.lineWidth = 10
        if toCross {
             layer.strokeEnd = 0 // in animation it will change to 1
        } else {
             layer.strokeEnd = 1 // in animation it will change to 0
        }
        layer.strokeColor = UIColor.black.cgColor
        layer.lineCap = kCALineCapRound
        //layer.fillColor = UIColor.clear.cgColor
        
        
        
        // Create the animation for the shape view
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.delegate = self
        if toCross {
            animation.toValue = 1
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
        } else {
            animation.toValue = 0
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
        }
        
        animation.duration = 6 // seconds
        animation.autoreverses = false
        
        
        animation.timingFunction = CAMediaTimingFunction(name: "easeOut")
        
        
        // Add the shape layer to view
        animatedView.layer.addSublayer(layer)
        
        // And finally add the linear animation to the shape!
        layer.add(animation, forKey: "line")
       
        
    }
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("Now, Now The animation has ended")
        if self.toCross {
            self.toCross = false
        } else {
            self.toCross = true
        }
        self.isDrawingNow = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
     
     
     
     
     
     // Create view and set its appearance
     let view = UIView(frame: CGRect(x: 0, y: 0, width: 150, height: 150))
     view.backgroundColor = .white
     
     
     
     
     
     animation.repeatCount = .infinity
     
     // And finally add the linear animation to the shape!
     layer.add(animation, forKey: "line")
     */
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
