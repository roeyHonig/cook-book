//
//  RecipesTableViewCell.swift
//  cook-book
//
//  Created by hackeru on 25 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class RecipesTableViewCell: UITableViewCell ,UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet var recipeNameLabel: UILabel!
    var specificIngredientsDataSource: [String?] = []
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specificIngredientsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    }

}
