//
//  RecipesTableViewCell.swift
//  cook-book
//
//  Created by hackeru on 25 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class RecipesTableViewCell: UITableViewCell {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var insideTableContainer: UIView!
    @IBOutlet var bottomSpacer: UIView!
    
    var specificIngredientsDataSource: [String?] = []
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func showSecondaryTable()  {
        let myFrame = CGRect(origin: self.insideTableContainer.frame.origin, size: CGSize(width: self.label.frame.width/* - cell.label.layoutMargins.left - cell.label.layoutMargins.right*/, height: 50))
        let testView = UIView(frame: myFrame)
        testView.backgroundColor = UIColor.blue
        
        //cell.insideTableContainer.addSubview(testView)
        self.contentView.addSubview(testView)
        
        // constraints
        let tableViewConstraintTop = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.label, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        let tableViewConstraintBottom = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: self.bottomSpacer, attribute: NSLayoutAttribute.top , multiplier: 1, constant: 0)
        let tableViewConstraintLeft = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.label, attribute: NSLayoutAttribute.trailing , multiplier: 1, constant: 0)
        let tableViewConstraintRight = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.label, attribute: NSLayoutAttribute.leading , multiplier: 1, constant: 0)
        
        // assign the constraint to a coummon annssector
        self.contentView.addConstraint(tableViewConstraintTop)
        self.contentView.addConstraint(tableViewConstraintBottom)
        self.contentView.addConstraint(tableViewConstraintLeft)
        self.contentView.addConstraint(tableViewConstraintRight)
    }
   

}
