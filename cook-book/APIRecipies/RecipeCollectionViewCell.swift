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
        // make sure recipe image has been loaded
        if sender.alpha > 0 {
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let myRecipyHeader = recipeHeader else {
                return
            }
            
            if sender.currentBackgroundImage == #imageLiteral(resourceName: "icons8-favorites-red-marchino") {
                sender.setBackgroundImage(#imageLiteral(resourceName: "icons8-favorites-steel"), for: .normal)
                appDelegate.defults.set(false, forKey: "\(myRecipyHeader.id)")
                //TODO: delete from core data
            } else {
                sender.setBackgroundImage(#imageLiteral(resourceName: "icons8-favorites-red-marchino"), for: .normal)
                appDelegate.defults.set(true, forKey: "\(myRecipyHeader.id)")
                //TODO: write to core data
            }
        }
    }
    
    var recipeHeader: RecipeHeader?
    
}
