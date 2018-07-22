//
//  OpeningScreenViewController.swift
//  cook-book
//
//  Created by hackeru on 6 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class OpeningScreenViewController: UIViewController {

    let numOfFlames = 100
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
        
        for i in 1...numOfFlames{
            let h: CGFloat
            let uiColor: UIColor
            let scaleX: CGFloat
            let scaleY: CGFloat
            let randomNumber = Int().RandomInt(min: 1, max: 4)
            switch randomNumber {
            case 1:
                uiColor = UIColor().redFlame()
                scaleY = 1.5
                scaleX = 1.5
                h = CGFloat(Double(Int().RandomInt(min: 75, max: 100)) / 100.0)
            case 2:
                uiColor = UIColor().orangeFlame()
                scaleY = 1.3
                scaleX = 1.3
                h = CGFloat(Double(Int().RandomInt(min: 50, max: 75)) / 100.0)
            case 3:
                uiColor = UIColor().yellowFlame()
                scaleY = 1.1
                scaleX = 1.1
                h = CGFloat(Double(Int().RandomInt(min: 25, max: 50)) / 100.0)
            case 4:
                uiColor = UIColor().whiteFlame()
                scaleY = 0.8
                scaleX = 0.8
                h = CGFloat(Double(Int().RandomInt(min: 10, max: 25)) / 100.0)
            default:
                uiColor = UIColor().orangeFlame()
                scaleY = 1.4
                scaleX = 1.4
                h = CGFloat(1)
            }
          
            //var alpha = CGFloat(Float(Double(numOfFlames) - Double(i-1) / Double(numOfFlames)))
            var alpha = CGFloat(Double((numOfFlames - i + 1)) / Double(numOfFlames))
            
            if alpha == 0 {alpha = 1}
            let angle = Double(Int().RandomInt(min: 1, max: 141) - 71)
            
            
            initSingleSubView(triHeight: h, parentView: layeredView, uicolor: uiColor , viewAlpha: alpha, skewAngle: angle, scaleX: scaleX, scaleY: scaleY)
            
        }
 
        
        
       // initSingleSubView(triHeight: CGFloat(1), parentView: layeredView, uicolor: UIColor().whiteFlame() , viewAlpha: CGFloat(1))
        
        
        
       
        
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
        
        for flameView in layeredViewSubViews{
            let originalHeight = flameView.frame.height
            let originalWidth = flameView.frame.width
            
            UIView.animateKeyframes(withDuration: 2, delay: 0, options: [UIViewKeyframeAnimationOptions.autoreverse ,UIViewKeyframeAnimationOptions.repeat], animations: {
                // define keyFrames
                
                UIView.addKeyframe(withRelativeStartTime: 0 / 6.0, relativeDuration: 0 / 6.0, animations: {
                    // aninmate stuff
                    
                    let angleY = flameView.skewAngle // angle between y axis and the y' axis after the skew
                    let scaleX = flameView.scaleX
                    let scaleY = flameView.scaleY * 0
                    flameView.transform = __CGAffineTransformMake(scaleX,
                                                                  0,
                                                                  CGFloat(atan(Double.pi * angleY / 180)),
                                                                  scaleY,
                                                                  CGFloat(-(Double(originalHeight) * sin(Double.pi * angleY / 180) / 2)) - 1.0 * self.signOf(number: angleY) * (scaleX-1) * originalWidth / 2,
                                                                  -(scaleY-1) * originalHeight / 2
                    )
                })
                
                UIView.addKeyframe(withRelativeStartTime: 0 / 6.0, relativeDuration: 1 / 6.0, animations: {
                    // aninmate stuff
                    
                    let angleY = flameView.skewAngle // angle between y axis and the y' axis after the skew
                    let scaleX = flameView.scaleX
                    let scaleY = flameView.scaleY * 1.2
                    flameView.transform = __CGAffineTransformMake(scaleX,
                                                                  0,
                                                                  CGFloat(atan(Double.pi * angleY / 180)),
                                                                  scaleY,
                                                                  CGFloat(-(Double(originalHeight) * sin(Double.pi * angleY / 180) / 2)) - 1.0 * self.signOf(number: angleY) * (scaleX-1) * originalWidth / 2,
                                                                  -(scaleY-1) * originalHeight / 2
                    )
                })
                
                UIView.addKeyframe(withRelativeStartTime: 1 / 6.0, relativeDuration: 1 / 6.0, animations: {
                    // aninmate stuff
                    
                    let angleY = flameView.skewAngle // angle between y axis and the y' axis after the skew
                    let scaleX = flameView.scaleX
                    let scaleY = flameView.scaleY * 1.1
                    flameView.transform = __CGAffineTransformMake(scaleX,
                                                                  0,
                                                                  CGFloat(atan(Double.pi * angleY / 180)),
                                                                  scaleY,
                                                                  CGFloat(-(Double(originalHeight) * sin(Double.pi * angleY / 180) / 2)) - 1.0 * self.signOf(number: angleY) * (scaleX-1) * originalWidth / 2,
                                                                  -(scaleY-1) * originalHeight / 2
                    )
                })
                
                UIView.addKeyframe(withRelativeStartTime: 2 / 6.0, relativeDuration: 1 / 6.0, animations: {
                    // aninmate stuff
                    
                    let angleY = flameView.skewAngle // angle between y axis and the y' axis after the skew
                    let scaleX = flameView.scaleX
                    let scaleY = flameView.scaleY * 1.3
                    flameView.transform = __CGAffineTransformMake(scaleX,
                                                                  0,
                                                                  CGFloat(atan(Double.pi * angleY / 180)),
                                                                  scaleY,
                                                                  CGFloat(-(Double(originalHeight) * sin(Double.pi * angleY / 180) / 2)) - 1.0 * self.signOf(number: angleY) * (scaleX-1) * originalWidth / 2,
                                                                  -(scaleY-1) * originalHeight / 2
                    )
                })
                
                UIView.addKeyframe(withRelativeStartTime: 3 / 6.0, relativeDuration: 1 / 6.0, animations: {
                    // aninmate stuff
                    
                    let angleY = flameView.skewAngle // angle between y axis and the y' axis after the skew
                    let scaleX = flameView.scaleX
                    let scaleY = flameView.scaleY * 1.2
                    flameView.transform = __CGAffineTransformMake(scaleX,
                                                                  0,
                                                                  CGFloat(atan(Double.pi * angleY / 180)),
                                                                  scaleY,
                                                                  CGFloat(-(Double(originalHeight) * sin(Double.pi * angleY / 180) / 2)) - 1.0 * self.signOf(number: angleY) * (scaleX-1) * originalWidth / 2,
                                                                  -(scaleY-1) * originalHeight / 2
                    )
                })
                
                UIView.addKeyframe(withRelativeStartTime: 4 / 6.0, relativeDuration: 1 / 6.0, animations: {
                    // aninmate stuff
                    
                    let angleY = flameView.skewAngle // angle between y axis and the y' axis after the skew
                    let scaleX = flameView.scaleX
                    let scaleY = flameView.scaleY * 1.4
                    flameView.transform = __CGAffineTransformMake(scaleX,
                                                                  0,
                                                                  CGFloat(atan(Double.pi * angleY / 180)),
                                                                  scaleY,
                                                                  CGFloat(-(Double(originalHeight) * sin(Double.pi * angleY / 180) / 2)) - 1.0 * self.signOf(number: angleY) * (scaleX-1) * originalWidth / 2,
                                                                  -(scaleY-1) * originalHeight / 2
                    )
                })
                
                UIView.addKeyframe(withRelativeStartTime: 5 / 6.0, relativeDuration: 1 / 6.0, animations: {
                    // aninmate stuff
                    
                    let angleY = flameView.skewAngle // angle between y axis and the y' axis after the skew
                    let scaleX = flameView.scaleX
                    let scaleY = flameView.scaleY * 1.3
                    flameView.transform = __CGAffineTransformMake(scaleX,
                                                                  0,
                                                                  CGFloat(atan(Double.pi * angleY / 180)),
                                                                  scaleY,
                                                                  CGFloat(-(Double(originalHeight) * sin(Double.pi * angleY / 180) / 2)) - 1.0 * self.signOf(number: angleY) * (scaleX-1) * originalWidth / 2,
                                                                  -(scaleY-1) * originalHeight / 2
                    )
                })
                
            }, completion: { (bool) in
                // upon completion
                flameView.transform = CGAffineTransform.identity
                print("animation is ")
            })
            
            /*
            UIView.animate(withDuration: 0.5, delay: 0, options: [UIViewAnimationOptions.autoreverse, UIViewAnimationOptions.repeat], animations: {
                // animate stuff
                self.backgroungView.alpha = 1
                //self.layeredView.transform = CGAffineTransform(translationX: 0, y: 300)
        
                let angleY = flameView.skewAngle // angle between y axis and the y' axis after the skew
                let scaleX = flameView.scaleX
                let scaleY = flameView.scaleY
                flameView.transform = __CGAffineTransformMake(scaleX,
                                                                                0,
                                                                                CGFloat(atan(Double.pi * angleY / 180)),
                                                                                scaleY,
                                                                                CGFloat(-(Double(flameView.frame.height) * sin(Double.pi * angleY / 180) / 2)) - 1.0 * self.signOf(number: angleY) * (scaleX-1) * flameView.frame.width / 2,
                                                                                -(scaleY-1) * flameView.frame.height / 2
                )
                
            }) { (bool) in
                //upon compleation
                flameView.transform = CGAffineTransform.identity
            }
             */
 
 
        }
        
        
        
    }
    
    func initSingleSubView(triHeight th: CGFloat, parentView pv: UIView,uicolor uic: UIColor, viewAlpha va: CGFloat, skewAngle sa: Double, scaleX sx: CGFloat, scaleY sy: CGFloat) {
        let customView = TrinagleUIView(triHeight: th, parentView: pv, uiColor: uic, viewAlpha: va, skewAngle: sa, scaleX: sx, scaleY: sy)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.alpha = va
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
    
    func signOf(number n: Double) -> CGFloat {
        return CGFloat(n < 0 ? -1 : 1)
    }

}

extension Int {
    func RandomInt(min: Int, max: Int) -> Int {
        if max < min { return min }
        return Int(arc4random_uniform(UInt32((max - min) + 1))) + min
    }
}

extension UIColor {
    func redFlame() -> UIColor {
        let uiColor = UIColor(red: CGFloat(230.0 / 255), green: CGFloat(86.0 / 255), blue :CGFloat(9.0 / 255), alpha: 1) //UIColor requires a float from 0 - 1, not from 0 - 255
        return uiColor
    }
    
    func orangeFlame() -> UIColor {
        let uiColor = UIColor(red: CGFloat(251.0 / 255), green: CGFloat(154.0 / 255), blue :CGFloat(7.0 / 255), alpha: 1) //UIColor requires a float from 0 - 1, not from 0 - 255
        return uiColor
    }
    
    func yellowFlame() -> UIColor {
        let uiColor = UIColor(red: CGFloat(254.0 / 255), green: CGFloat(204.0 / 255), blue :CGFloat(44.0 / 255), alpha: 1) //UIColor requires a float from 0 - 1, not from 0 - 255
        return uiColor
    }
    
    func whiteFlame() -> UIColor {
        let uiColor = UIColor(red: CGFloat(254.0 / 255), green: CGFloat(228.0 / 255), blue :CGFloat(203.0 / 255), alpha: 1) //UIColor requires a float from 0 - 1, not from 0 - 255
        return uiColor
    }
}


