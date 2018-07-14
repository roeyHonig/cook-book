//
//  ingredientsForEachShoopingListRecipeTableViewCell.swift
//  cook-book
//
//  Created by hackeru on 25 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class ingredientsForEachShoopingListRecipeTableViewCell: UITableViewCell {

    @IBOutlet var nonAnimatingLayerView: UIView!
    @IBOutlet var innerCircleImageView: UIImageView!
    @IBOutlet var secondaryLabel: UILabel!
    var thisCellIndexPathRow: Int! // i'm sure to provide this
    var thisCellGlobalRecipyDBNumber: Int! // i'm sure to provide this
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        let tapGestureRecognition = UITapGestureRecognizer()
        tapGestureRecognition.addTarget(self, action: #selector(toggleIngredientCheackedStatus))
        self.contentView.addGestureRecognizer(tapGestureRecognition)
    }
    
    @objc func toggleIngredientCheackedStatus() {
        
        if self.innerCircleImageView.alpha == 0 {
            self.innerCircleImageView.alpha = 1
            nonAnimatingLayerView.alpha = 1
            self.drawStaticCrossLines(inside: self.nonAnimatingLayerView, theNumberOfLines: 1)
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            appDelegate.updateDataInCoreDataEntitesMatchedBy(attribute1: "idOfRecipe", attribute2: "index", value1: thisCellGlobalRecipyDBNumber, value2: (thisCellIndexPathRow + 1), newValueAttribute: "cheacked", newValue: 1)
            
        } else {
            self.innerCircleImageView.alpha = 0
            nonAnimatingLayerView.alpha = 0
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            appDelegate.updateDataInCoreDataEntitesMatchedBy(attribute1: "idOfRecipe", attribute2: "index", value1: thisCellGlobalRecipyDBNumber, value2: (thisCellIndexPathRow + 1), newValueAttribute: "cheacked", newValue: 0)
            
        }
    }

    
    func drawStaticCrossLines(inside view: UIView, theNumberOfLines num:Int)  {
       // iterate over all the lines need to be plotted
        guard num > 0 else {
            return
        }
        for i in 1...num {
             let layer = CAShapeLayer()
            let path = UIBezierPath()
            // draw the line from left to right
            /*
            let numberOfLines = Float(num)
            let myCGRectSize = CGSize(width: view.frame.width, height: view.frame.height )
            let myOriginX = view.frame.minX
            let indexAsFloat = Float(i - 1)
            let myOriginY = CGFloat(indexAsFloat) * view.frame.height / CGFloat(numberOfLines)
            let myOrigin = CGPoint(x: myOriginX, y: myOriginY)
            */
            //let rec = CGRect(origin: myOrigin, size: myCGRectSize)
            path.move(to: CGPoint(x: view.bounds.minX + 5 , y: view.bounds.midY))
            path.addLine(to: CGPoint(x: view.bounds.maxX - 5, y: view.bounds.midY))
            layer.path = path.cgPath
            
            // Set up the appearance of the shape layer
            layer.lineWidth = 5
            layer.strokeColor = UIColor.black.cgColor
            layer.lineCap = kCALineCapRound
            layer.strokeEnd = 1
            
            view.layer.addSublayer(layer)
        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
