//
//  ingredientsForEachShoopingListRecipeTableViewCell.swift
//  cook-book
//
//  Created by hackeru on 25 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class ingredientsForEachShoopingListRecipeTableViewCell: UITableViewCell, CAAnimationDelegate {

    @IBOutlet var nonAnimatingCustomUIVIew: CustomUIView7!
    @IBOutlet var animatedLayerUIView: UIView!
    
    @IBOutlet var innerCircleImageView: UIImageView!
    @IBOutlet var secondaryLabel: UILabel!
    var thisCellIndexPathRow: Int! // i'm sure to provide this
    var thisCellGlobalRecipyDBNumber: Int! // i'm sure to provide this
    
    var isDrawingNow = false // allowing us to lock the pressing of the ingredient while it's beeing animated to prevent irredic behaivor
    //let myLayer = CAShapeLayer()
    var toCross = true // boolean to decide whteher to cross out the ingrediant or roll it back
    var numOfVerticalSections: Int = 0
    var i: Int = 1 // a running index like in a for loop
    var myLayers: [CAShapeLayer] = []
    var haveTheArrayOfLayersBeenInit = false // we only want to init once, so to not loose the pointers to the layers in a single seesion
    
    var staticCrossedViews: [CustomUIView9] = []
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let tapGestureRecognition = UITapGestureRecognizer()
        tapGestureRecognition.addTarget(self, action: #selector(toggleIngredientCheackedStatus))
        self.contentView.addGestureRecognizer(tapGestureRecognition)
    }
    
    
    
    @objc func toggleIngredientCheackedStatus() {
        
        if !isDrawingNow {
            // static cross
            if self.innerCircleImageView.alpha == 0 {
                toCross = true
                
                self.innerCircleImageView.alpha = 1
                self.nonAnimatingCustomUIVIew.alpha = 1
                print("some prograss bla bla, the heigt is: \(nonAnimatingCustomUIVIew.frame.height) and the line height is: \(secondaryLabel.font.lineHeight)")
                //self.drawStaticCrossLines(inside: self.nonAnimatingLayerView, theNumberOfLines: 1)
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                appDelegate.updateDataInCoreDataEntitesMatchedBy(attribute1: "idOfRecipe", attribute2: "index", value1: thisCellGlobalRecipyDBNumber, value2: (thisCellIndexPathRow + 1), newValueAttribute: "cheacked", newValue: 1)
                let numOfLines = Int(Float(nonAnimatingCustomUIVIew.frame.height / secondaryLabel.font.lineHeight))
                appDelegate.updateDataInCoreDataEntitesMatchedBy(attribute1: "idOfRecipe", attribute2: "index", value1: thisCellGlobalRecipyDBNumber, value2: (thisCellIndexPathRow + 1), newValueAttribute: "ingredientNumTextLines", newValue: numOfLines)
                nonAnimatingCustomUIVIew.numOfVerticalSections = numOfLines
                nonAnimatingCustomUIVIew.setNeedsDisplay()
                numOfVerticalSections = numOfLines
                // let's also init the Array of layers
                if myLayers.count == 0 && !haveTheArrayOfLayersBeenInit{
                    haveTheArrayOfLayersBeenInit = true
                    myLayers.removeAll()
                    for j in 1...numOfLines {
                        let tmpLayer = CAShapeLayer()
                        myLayers.append(tmpLayer)
                    }
                }
                
                initArrayOfViews()
                
                
            } else {
                toCross = false
                
                self.innerCircleImageView.alpha = 0
                self.nonAnimatingCustomUIVIew.alpha = 1
                guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                appDelegate.updateDataInCoreDataEntitesMatchedBy(attribute1: "idOfRecipe", attribute2: "index", value1: thisCellGlobalRecipyDBNumber, value2: (thisCellIndexPathRow + 1), newValueAttribute: "cheacked", newValue: 0)
                
                // let's also init the Array of layers
                if myLayers.count == 0 && !haveTheArrayOfLayersBeenInit{
                    haveTheArrayOfLayersBeenInit = true
                    myLayers.removeAll()
                    for j in 1...numOfVerticalSections {
                        let tmpLayer = CAShapeLayer()
                        myLayers.append(tmpLayer)
                    }
                }
                
                
            }
            
           
            
            let myLayer = myLayers[i - 1]
            // animate the dynamic cross
            self.animateCrossPath(in: animatedLayerUIView, withLayer: myLayer ,willBeCrossed: toCross, forTotalNumberOfCrossLines: numOfVerticalSections)
            
        }
        
        
    }

    
    func animateCrossPath(in view: UIView, withLayer layer: CAShapeLayer ,willBeCrossed bool: Bool, forTotalNumberOfCrossLines num: Int) {
        isDrawingNow = true
        
        guard numOfVerticalSections > 0, myLayers.count > 0 else {
            isDrawingNow = false
            return
        }
        
       
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
        animation.duration = 0.1 // seconds
        animation.autoreverses = false
        animation.timingFunction = CAMediaTimingFunction(name: "easeOut")
        
        // Add the shape layer to view
        view.layer.addSublayer(layer)
        
        // And finally add the linear animation to the shape!
        layer.add(animation, forKey: "line")
     
    }
    
    
    func animationDidStart(_ anim: CAAnimation) {
        if !toCross {
            // we are rolling back
            staticCrossedViews[i - 1].alpha = 0
        }
    }
    
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if toCross {
            // we are crossing out
            staticCrossedViews[i - 1].alpha = 1
        } else {
            // we just roll back and we don't want to see the round cap of the layer
            myLayers[i - 1].strokeColor = UIColor.clear.cgColor
        }
        
        i = i + 1
        
        if i > numOfVerticalSections {
            // congrtiolations, we've just finished performing our last animation, we've crossed out every line of text!
            if self.toCross {
                self.toCross = false
            } else {
                self.toCross = true
            }
            self.isDrawingNow = false
            i = 1
        
        } else {
            // we're continuing to the next animation
            let myLayer = myLayers[i - 1]
            self.animateCrossPath(in: animatedLayerUIView, withLayer: myLayer ,willBeCrossed: toCross, forTotalNumberOfCrossLines: numOfVerticalSections)
        }
        
        
    }
    
    func staticPreReverseAnimation(in view: UIView, forTotalNumberOfCrossLines num: Int) {
        for k in 1...myLayers.count {
            print ("instetntlly drawing a line")
            // prepre the path
            let path = UIBezierPath()
            // draw the line from left to right
            let rect = view.bounds
            let rec = CGRect(x: rect.minX, y: CGFloat(Float(k - 1)) * (rect.height / CGFloat(Float(num))), width: rect.width, height: rect.height / CGFloat(Float(num)))
            path.move(to: CGPoint(x: rec.minX + 5, y: rec.midY))
            path.addLine(to: CGPoint(x: rec.maxX - 5, y: rec.midY))
           
            myLayers[k - 1].path = path.cgPath
            
            // Set up the appearance of the shape layer
            myLayers[k - 1].lineWidth = 5
            //myLayers[k - 1].strokeEnd = 1
            myLayers[k - 1].strokeColor = UIColor.purple.cgColor
            myLayers[k - 1].lineCap = kCALineCapRound
            
            // strike
           // path.stroke()
        }
    }
    
    func initArrayOfViews() {
        if staticCrossedViews.count > 0{
            for kk in 1...staticCrossedViews.count {
                staticCrossedViews[kk - 1].removeFromSuperview()
            }
        }
        
        // ok, lets init the array of views
        staticCrossedViews.removeAll()
        guard numOfVerticalSections > 0 else {
            return
        }
        for k in 1...numOfVerticalSections {
            let myCustomView = CustomUIView9(currentNumOfVerticalSections: k, outOfTotalNumOfVerticalSections: numOfVerticalSections, toBeSubViewdIn: nonAnimatingCustomUIVIew)
            myCustomView.translatesAutoresizingMaskIntoConstraints = false
            myCustomView.backgroundColor = UIColor.clear
            myCustomView.alpha = 0
            
            //add subview
            self.nonAnimatingCustomUIVIew.addSubview(myCustomView)
            
            // constraints
            let ConstraintTop = NSLayoutConstraint(item: self.nonAnimatingCustomUIVIew, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: myCustomView, attribute: NSLayoutAttribute.top , multiplier: 1, constant: 0)
            let ConstraintBottom = NSLayoutConstraint(item: self.nonAnimatingCustomUIVIew, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: myCustomView, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
            let ConstraintTrailing = NSLayoutConstraint(item: self.nonAnimatingCustomUIVIew, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: myCustomView, attribute: NSLayoutAttribute.trailing , multiplier: 1, constant: 0)
            let ConstraintLeading = NSLayoutConstraint(item: self.nonAnimatingCustomUIVIew, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: myCustomView, attribute: NSLayoutAttribute.leading , multiplier: 1, constant: 0)
            
            // assign the constraint to a coummon annssector
            self.contentView.addConstraint(ConstraintTop)
            self.contentView.addConstraint(ConstraintBottom)
            self.contentView.addConstraint(ConstraintTrailing)
            self.contentView.addConstraint(ConstraintLeading)
            
            // redrawing
            myCustomView.setNeedsDisplay()
            
            // appending
            staticCrossedViews.append(myCustomView)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
