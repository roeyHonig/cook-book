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
    var layeredViewSubViews: [TrinagleUIView] = []
    var myHeights: [NSLayoutConstraint] = []
    @IBOutlet var backgroungView: UIView!
    var myLayers: [CAShapeLayer] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
        paintingTheFrame()
        paintingOrangeDiagonal()
        //paintingSemiTransperentBlueTrinagle()
        
        
        //--------------
        // init the views
        initSingleSubView(triHeight: CGFloat(1), parentView: layeredView, red: 46.0/255.0, green: 44.0/255.0, blue: 171.0/255.0, viewAlpha: CGFloat(1))
        
        
        
       
        
        //----------
        /*
        UIView.animate(withDuration: 2, animations: {
            // animate stuff
            self.backgroungView.alpha = 1
            //self.layeredView.transform = CGAffineTransform(translationX: 0, y: 300)
            //-------------
            let angleY = 45.0 // angle between y axis and the y' axis after the skew
            //
            self.layeredViewSubViews[0].transform = __CGAffineTransformMake(1, 0, CGFloat(atan(Double.pi * angleY / 180)) ,1, CGFloat(-(Double(self.layeredViewSubViews[0].frame.height) * sin(Double.pi * angleY / 180) / 2)), 0)
            //------------------
        }) { (bool) in
            //upon compleation
            
        }
        */
        
        UIView.animate(withDuration: 1, delay: 0, options: [UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat], animations: {
            // animate stuff
            self.backgroungView.alpha = 1
            //self.layeredView.transform = CGAffineTransform(translationX: 0, y: 300)
            //----Botom Right anchored flames---------
            let angleY = 80.0 // angle between y axis and the y' axis after the skew
            let scaleX = CGFloat(0.5)
            let scaleY = CGFloat(1.4)
            self.layeredViewSubViews[0].transform = __CGAffineTransformMake(scaleX,
                                                                            0,
                                                                            CGFloat(atan(Double.pi * angleY / 180)),
                                                                            scaleY,
                                                                            CGFloat(-(Double(self.layeredViewSubViews[0].frame.height) * sin(Double.pi * angleY / 180) / 2)) - (scaleX-1) * self.layeredViewSubViews[0].frame.width / 2,
                                                                            -(scaleY-1) * self.layeredViewSubViews[0].frame.height / 2
            )
            //------------------
        }) { (bool) in
            //upon compleation
            self.layeredViewSubViews[0].transform = CGAffineTransform.identity
        }
        
    }
    
    func initSingleSubView(triHeight th: CGFloat, parentView pv: UIView,red r: Float, green g: Float, blue b: Float, viewAlpha va: CGFloat) {
        let customView = TrinagleUIView(triHeight: th, parentView: pv, red: r, green: g, blue: b, viewAlpha: va)
        customView.translatesAutoresizingMaskIntoConstraints = false
        layeredView.addSubview(customView)
        // constraints
        let constraintTop = NSLayoutConstraint(item: layeredView, attribute: NSLayoutAttribute.height, relatedBy: .equal, toItem: customView, attribute: NSLayoutAttribute.height , multiplier: 1, constant: 0)
        let constraintBottom = NSLayoutConstraint(item: layeredView, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: customView, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        let constraintTrailing = NSLayoutConstraint(item: layeredView, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: customView, attribute: NSLayoutAttribute.width , multiplier: 1, constant: 0)
        let constraintLeading = NSLayoutConstraint(item: layeredView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: customView, attribute: NSLayoutAttribute.leading , multiplier: 1, constant: 0)
        // assign the constraint to a coummon annssector
        view.addConstraint(constraintTop)
        view.addConstraint(constraintBottom)
        view.addConstraint(constraintTrailing)
        view.addConstraint(constraintLeading)
        
        layeredViewSubViews.append(customView)
        myHeights.append(constraintTop)
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
