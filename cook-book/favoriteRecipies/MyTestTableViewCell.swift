//
//  MyTestTableViewCell.swift
//  cook-book
//
//  Created by hackeru on 5 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class MyTestTableViewCell: UITableViewCell {

    
    @IBOutlet var testLabel: UILabel!
    
    var cellRecipyHeader: RecipeHeader?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
