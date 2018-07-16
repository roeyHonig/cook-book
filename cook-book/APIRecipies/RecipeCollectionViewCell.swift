//
//  RecipeCollectionViewCell.swift
//  cook-book
//
//  Created by hackeru on 7 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var lab: UILabel!
    @IBOutlet var recipeImage: UIImageView!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var favoriteBtn: UIButton!
    
    
    @IBAction func toggleingFavoriteBtn(_ sender: UIButton) {
        if sender.currentBackgroundImage == #imageLiteral(resourceName: "icons8-favorites-red-marchino") {
            sender.setBackgroundImage(#imageLiteral(resourceName: "icons8-favorites-steel"), for: .normal)
        } else {
            sender.setBackgroundImage(#imageLiteral(resourceName: "icons8-favorites-red-marchino"), for: .normal)
        }
        
    }
    
    var recipeHeader: RecipeHeader?
    
}
