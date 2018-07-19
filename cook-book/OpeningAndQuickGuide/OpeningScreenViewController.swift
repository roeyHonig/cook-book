//
//  OpeningScreenViewController.swift
//  cook-book
//
//  Created by hackeru on 6 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class OpeningScreenViewController: UIViewController {

    
    @IBOutlet var layeredView: UIView!
    
    
    @IBOutlet var backgroungView: UIView!
    var myLayers: [CAShapeLayer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        paintingTheFrame()
        paintingOrangeDiagonal()
        //paintingSemiTransperentBlueTrinagle()
        
        UIView.animate(withDuration: 3, animations: {
            // animate stuff
            self.backgroungView.alpha = 1
            //self.layeredView.transform = CGAffineTransform(translationX: 0, y: 300)
        }) { (bool) in
            //upon compleation
            print("Congrats, animation is over")
            //self.performSegue(withIdentifier: "startApp", sender: self)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func paintingTheFrame() {
        let boundaryShapeLayer = CAShapeLayer()
        
        
        boundaryShapeLayer.frame = layeredView.bounds
        
        boundaryShapeLayer.lineWidth = 2.0
        boundaryShapeLayer.fillColor = nil
        boundaryShapeLayer.strokeColor = UIColor.purple.cgColor
        
        boundaryShapeLayer.path = UIBezierPath(rect: boundaryShapeLayer.bounds).cgPath
        layeredView.layer.addSublayer(boundaryShapeLayer)
    }
    
    func paintingOrangeDiagonal() {
        let boundaryShapeLayer = CAShapeLayer()
        boundaryShapeLayer.frame = layeredView.bounds
        
        boundaryShapeLayer.lineWidth = 2.0
        boundaryShapeLayer.fillColor = nil
        boundaryShapeLayer.strokeColor = UIColor.orange.cgColor
        
        let path = UIBezierPath()
        
        // the corrdinates here are in the bounds, that is realitive to the view, that is, origin is 0,0
        
        path.move(to: CGPoint(x: 0, y: 0))
        path.addLine(to: CGPoint(x: 240, y: 128))
        
        boundaryShapeLayer.path = path.cgPath
        layeredView.layer.addSublayer(boundaryShapeLayer)
    }
    
    func paintingSemiTransperentBlueTrinagle() {
        let boundaryShapeLayer = CAShapeLayer()
        boundaryShapeLayer.frame = layeredView.bounds
        
        boundaryShapeLayer.lineWidth = 2.0
        //boundaryShapeLayer.strokeColor = UIColor.blue.cgColor
        let uiColor = UIColor(red: 46.0/255.0, green: 44.0/255.0, blue: 171.0/255.0, alpha: 1) //UIColor requires a float from 0 - 1, not from 0 - 255
        boundaryShapeLayer.fillColor = uiColor.cgColor
        boundaryShapeLayer.strokeColor = uiColor.cgColor
        boundaryShapeLayer.opacity = 0
        
        let path = UIBezierPath()
        // the corrdinates here are in the bounds, that is realitive to the view, that is, origin is 0,0
        path.move(to: CGPoint(x: layeredView.bounds.midX, y: layeredView.bounds.minY))
        path.addLine(to: CGPoint(x: layeredView.bounds.minX, y: layeredView.bounds.maxY))
        path.addLine(to: CGPoint(x: layeredView.bounds.maxX, y: layeredView.bounds.maxY))
        path.close()
        
        boundaryShapeLayer.path = path.cgPath
        
        // Create the animation for the shape view
        let animation = CABasicAnimation(keyPath: "opacity")
        //animation.delegate = self
        animation.toValue = 1
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.duration = 3 // seconds
        animation.autoreverses = false
        animation.timingFunction = CAMediaTimingFunction(name: "easeOut")
        
        // add th layer to a view
        layeredView.layer.addSublayer(boundaryShapeLayer)
        // add animation to the layer
        boundaryShapeLayer.add(animation, forKey: "opacity")
    }
    
    /*
     //--------------------------------------------------------
     
     // prepre the path
     let path = UIBezierPath()
     // draw the line from left to right
     let rect = view.bounds
     let rec = CGRect(x: rect.minX, y: CGFloat(Float(i - 1)) * (rect.height / CGFloat(Float(num))), width: rect.width, height: rect.height / CGFloat(Float(num)))
     path.move(to: CGPoint(x: rec.minX + 5, y: rec.midY))
     path.addLine(to: CGPoint(x: rec.maxX - 5, y: rec.midY))
     layer.path = path.cgPath // return a CGpath from the UIBezierPath and assign it to the path property of the layer
     
     // Set up the appearance of the shape layer
     layer.lineWidth = 5
     if bool {
     layer.strokeEnd = 0 // in animation it will change to 1
     
     } else {
     layer.strokeEnd = 1 // in animation it will change to 0
     }
     layer.strokeColor = UIColor.lightGray.cgColor
     layer.lineCap = kCALineCapRound
     
     // Create the animation for the shape view
     let animation = CABasicAnimation(keyPath: "strokeEnd")
     animation.delegate = self
     if bool {
     animation.toValue = 1
     animation.fillMode = kCAFillModeForwards
     animation.isRemovedOnCompletion = false
     } else {
     animation.toValue = 0
     animation.fillMode = kCAFillModeForwards
     animation.isRemovedOnCompletion = false
     }
     animation.duration = 1 // seconds
     animation.autoreverses = false
     animation.timingFunction = CAMediaTimingFunction(name: "easeOut")
     
     // Add the shape layer to view
     view.layer.addSublayer(layer)
     
     // And finally add the linear animation to the shape!
     layer.add(animation, forKey: "line")
     
     
     //--------------------------------------------------------
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
