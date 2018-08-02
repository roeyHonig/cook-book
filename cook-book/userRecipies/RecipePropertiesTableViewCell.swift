//
//  RecipePropertiesTableViewCell.swift
//  cook-book
//
//  Created by hackeru on 21 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class RecipePropertiesTableViewCell: UITableViewCell {

    
    @IBOutlet var propertyTextView: UITextView!
    
    @IBOutlet var textHeightConstraint: NSLayoutConstraint!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //textHeightConstraint.constant = propertyTextView.intrinsicContentSize.height
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
