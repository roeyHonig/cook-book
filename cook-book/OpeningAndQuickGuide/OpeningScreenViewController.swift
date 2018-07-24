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
          
            
            var alpha = CGFloat(Double((numOfFlames - i + 1)) / Double(numOfFlames))
            if alpha == 0 {alpha = 1}
            let angle = Double(Int().RandomInt(min: 1, max: 141) - 71)
            
            initSingleSubView(triHeight: h, parentView: layeredView, uicolor: uiColor , viewAlpha: alpha, skewAngle: angle, scaleX: scaleX, scaleY: scaleY)
            
        }
    
        presentBurningFlamesAnimation(withDuration: 3.0)
        
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

    
    func presentBurningFlamesAnimation(withDuration t: Double) {
        var animatinoCounter = 1
        for flameView in layeredViewSubViews{
            let originalHeight = flameView.frame.height
            let originalWidth = flameView.frame.width
            
            
            UIView.animateKeyframes(withDuration: t, delay: 0, options: [], animations: {
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
                    let scaleY = flameView.scaleY * 0.5
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
                    let scaleY = flameView.scaleY * 0.3
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
                    let scaleY = flameView.scaleY * 1
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
                    let scaleY = flameView.scaleY * 0.5
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
                    let scaleY = flameView.scaleY * 1.2
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
                    let scaleY = flameView.scaleY * 1
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
                animatinoCounter = animatinoCounter + 1
                //flameView.transform = CGAffineTransform.identity
                print(animatinoCounter)
                if animatinoCounter >= self.layeredViewSubViews.count {
                    var bool = false
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                        return
                    }
                    if var shouldSKipQuickGuide = appDelegate.defults.value(forKey: "shouldSkipQuickGuid") as? Bool {
                        bool = shouldSKipQuickGuide
                    }
                    
                    
                    if bool {
                        // don't present quickGuide and go strait to the recipes themself
                        self.performSegue(withIdentifier: "startAppWithNoQuickGuide", sender: self)
                    } else {
                        // present quick guide
                        self.performSegue(withIdentifier: "startApp", sender: self)
                    }
                    
                    
                }
                
            })
            
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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


