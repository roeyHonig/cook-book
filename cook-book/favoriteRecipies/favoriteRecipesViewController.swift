//
//  favoriteRecipesViewController.swift
//  cook-book
//
//  Created by hackeru on 16 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//  currentlly just an example for loading url image

import UIKit
import SDWebImage

class favoriteRecipesViewController: UIViewController {
    
    
    @IBOutlet var animatedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view.
        
       
        
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // prepre the path
        let path = UIBezierPath()
        let rect = animatedView.frame
        
        // cross line
        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        
        
        // Create shape layer and add the path to it
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        
        // Set up the appearance of the shape layer
        layer.strokeEnd = 0 // in animation it will change to 1
        layer.lineWidth = 10
        layer.strokeColor = UIColor.black.cgColor
        //layer.fillColor = UIColor.clear.cgColor
        
        // Add the shape layer to view
        animatedView.layer.addSublayer(layer)
        
        // Create the animation for the shape view
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.toValue = 1
        animation.duration = 2 // seconds
        animation.autoreverses = false
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.timingFunction = CAMediaTimingFunction(name: "easeOut")
        
        
        // And finally add the linear animation to the shape!
        layer.add(animation, forKey: "line")
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
