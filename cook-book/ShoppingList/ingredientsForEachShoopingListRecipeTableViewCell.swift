//
//  ingredientsForEachShoopingListRecipeTableViewCell.swift
//  cook-book
//
//  Created by hackeru on 25 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class ingredientsForEachShoopingListRecipeTableViewCell: UITableViewCell {

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
        print ("Hhhhhhhhhhhhhelllo")
        if self.innerCircleImageView.alpha == 0 {
            self.innerCircleImageView.alpha = 1
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            appDelegate.updateDataInCoreDataEntitesMatchedBy(attribute1: "idOfRecipe", attribute2: "index", value1: thisCellGlobalRecipyDBNumber, value2: (thisCellIndexPathRow + 1), newValueAttribute: "cheacked", newValue: 1)
            
        } else {
            self.innerCircleImageView.alpha = 0
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            appDelegate.updateDataInCoreDataEntitesMatchedBy(attribute1: "idOfRecipe", attribute2: "index", value1: thisCellGlobalRecipyDBNumber, value2: (thisCellIndexPathRow + 1), newValueAttribute: "cheacked", newValue: 0)
            
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
