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
        initSingleSubView(triHeight: CGFloat(0), parentView: layeredView, red: 46.0/255.0, green: 44.0/255.0, blue: 171.0/255.0, viewAlpha: CGFloat(1))
        
        
        
       
        
        //----------
        
        UIView.animate(withDuration: 3, animations: {
            // animate stuff
            self.backgroungView.alpha = 1
            //self.layeredView.transform = CGAffineTransform(translationX: 0, y: 300)
        }) { (bool) in
            //upon compleation
            print("Congrats, animation is over")
            self.layeredViewSubViews[0].setNeedsDisplay()
            UIView.animate(withDuration: 5, animations: {
                self.layeredViewSubViews[0].alpha = 0.99
                self.layeredViewSubViews[0].triHeight = 0.5
            }, completion: { (bool) in
                print ("the 0.5 is just now completing")
                self.layeredViewSubViews[0].setNeedsDisplay()
                UIView.animate(withDuration: 5, animations: {
                    self.layeredViewSubViews[0].alpha = 1
                    self.layeredViewSubViews[0].triHeight = 1
                }, completion: { (bool) in
                    self.layeredViewSubViews[0].setNeedsDisplay()
                    print ("the 1 is just now completing")
                })
            })
            
            
            
            //self.performSegue(withIdentifier: "startApp", sender: self)
            
            /*
            UIView.animateKeyframes(withDuration: 2, delay: 0, options: [], animations: {
                //
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5, animations: {
                    //
                    self.layeredViewSubViews[0].triHeight = CGFloat(1)
                    let rect = self.layeredView.frame
                    self.layeredViewSubViews[0].setNeedsDisplay()
                })
            }, completion: nil)
            */
            
            /*
            let relitiveDurationForThisAnimation: Double = 0.1
            
            
            
            UIView.animateKeyframes(withDuration: 5.0, delay: 0, options: [UIViewKeyframeAnimationOptions.layoutSubviews], animations: {
                // define keyframes here
                
                UIView.addKeyframe(withRelativeStartTime: 0.0 , relativeDuration: 1 / 2.0, animations: {
                    // change something
                    
                    for customView in self.layeredViewSubViews {
                        customView.triHeight = 0.1
                        self.view.alpha = 0.99
                        //self.view.layoutIfNeeded()
                        //customView.setNeedsDisplay()
                        //customView.alpha = 0
                        //customView.removeFromSuperview()
                        //self.initSingleSubView(triHeight: CGFloat(0.3), parentView: self.layeredView, red: 46.0/255.0, green: 44.0/255.0, blue: 171.0/255.0, viewAlpha: CGFloat(1))
                        print(0.1)
                    }
                   
                })
                
                
                
                UIView.addKeyframe(withRelativeStartTime: 0.5 , relativeDuration: 1 / 2.0, animations: {
                    // change something
                    
                    for customView in self.layeredViewSubViews {
                        customView.setNeedsDisplay()
                        customView.triHeight = 0.2
                        self.view.alpha = 0.99
                        //self.view.layoutIfNeeded()
                        
                        //customView.alpha = 0
                        //customView.removeFromSuperview()
                        //self.initSingleSubView(triHeight: CGFloat(0.3), parentView: self.layeredView, red: 46.0/255.0, green: 44.0/255.0, blue: 171.0/255.0, viewAlpha: CGFloat(1))
                        print(0.1)
                    }
                    
                })
                
            
            }) { (bool) in
                //upon completion
                print("over")
            }
            */
            
        }
        
    }
    
    func initSingleSubView(triHeight th: CGFloat, parentView pv: UIView,red r: Float, green g: Float, blue b: Float, viewAlpha va: CGFloat) {
        let customView = TrinagleUIView(triHeight: th, parentView: pv, red: r, green: g, blue: b, viewAlpha: va)
        customView.translatesAutoresizingMaskIntoConstraints = false
        layeredView.addSubview(customView)
        // constraints
        let constraintTop = NSLayoutConstraint(item: layeredView, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: customView, attribute: NSLayoutAttribute.top , multiplier: 1, constant: 0)
        let constraintBottom = NSLayoutConstraint(item: layeredView, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: customView, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        let constraintTrailing = NSLayoutConstraint(item: layeredView, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: customView, attribute: NSLayoutAttribute.trailing , multiplier: 1, constant: 0)
        let constraintLeading = NSLayoutConstraint(item: layeredView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: customView, attribute: NSLayoutAttribute.leading , multiplier: 1, constant: 0)
        // assign the constraint to a coummon annssector
        view.addConstraint(constraintTop)
        view.addConstraint(constraintBottom)
        view.addConstraint(constraintTrailing)
        view.addConstraint(constraintLeading)
        
        layeredViewSubViews.append(customView)
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
