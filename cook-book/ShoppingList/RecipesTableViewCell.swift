//
//  RecipesTableViewCell.swift
//  cook-book
//
//  Created by hackeru on 25 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class RecipesTableViewCell: UITableViewCell, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet var headerContainer: UIView!
    
    @IBOutlet var label: UILabel!
    @IBOutlet var insideTableContainer: UIView!
    @IBOutlet var bottomSpacer: UIView!
    
    var isSecondaryTableOpen = false
    var myFrame = CGRect()
    var testView = UIView()
    var heightConstraint = NSLayoutConstraint()
    
    var specificIngredientsDataSource: [String?] = []
    
    @IBOutlet var secondaryTable: UITableView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        //secondaryTable.removeFromSuperview()
        secondaryTable.delegate = self
        secondaryTable.dataSource = self
        
        myFrame = CGRect(origin: self.insideTableContainer.frame.origin, size: CGSize(width: self.label.frame.width/* - cell.label.layoutMargins.left - cell.label.layoutMargins.right*/, height: 50))
        testView = UIView(frame: myFrame)
        testView.backgroundColor = UIColor.blue
        
        secondaryTable.removeFromSuperview()
        
        // very important!!!, otherwise the initial dimenstions becomes constraint themself and override our deseiered constraints
        testView.translatesAutoresizingMaskIntoConstraints = false
        secondaryTable.translatesAutoresizingMaskIntoConstraints = false
        showSecondaryTable()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        //testView.removeFromSuperview()
        
    }
    
    func showSecondaryTable()  {
        self.contentView.addSubview(testView)
        
        // constraints
        let tableViewConstraintTop = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.headerContainer, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        let tableViewConstraintBottom = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: self.bottomSpacer, attribute: NSLayoutAttribute.top , multiplier: 1, constant: 0)
        let tableViewConstraintLeft = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: self.headerContainer, attribute: NSLayoutAttribute.trailing , multiplier: 1, constant: 0)
        let tableViewConstraintRight = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.headerContainer, attribute: NSLayoutAttribute.leading , multiplier: 1, constant: 0)
        self.heightConstraint = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.height, relatedBy: .equal, toItem: self.headerContainer, attribute: NSLayoutAttribute.height, multiplier: 0, constant: 150)
        
        
        // assign the constraint to a coummon annssector
        self.contentView.addConstraint(heightConstraint)
        self.contentView.addConstraint(tableViewConstraintTop)
        self.contentView.addConstraint(tableViewConstraintBottom)
        self.contentView.addConstraint(tableViewConstraintLeft)
        self.contentView.addConstraint(tableViewConstraintRight)
        
        self.contentView.addSubview(secondaryTable)
        
        // constraints
        let tableViewConstraintTop1 = NSLayoutConstraint(item: secondaryTable, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: testView, attribute: NSLayoutAttribute.top , multiplier: 1, constant: 0)
        let tableViewConstraintTop2 = NSLayoutConstraint(item: secondaryTable, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: testView, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        let tableViewConstraintTop3 = NSLayoutConstraint(item: secondaryTable, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: testView, attribute: NSLayoutAttribute.trailing , multiplier: 1, constant: 0)
        let tableViewConstraintTop4 = NSLayoutConstraint(item: secondaryTable, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: testView, attribute: NSLayoutAttribute.leading , multiplier: 1, constant: 0)
        // assign the constraint to a coummon annssector
        self.contentView.addConstraint(tableViewConstraintTop1)
        self.contentView.addConstraint(tableViewConstraintTop2)
        self.contentView.addConstraint(tableViewConstraintTop3)
        self.contentView.addConstraint(tableViewConstraintTop4)
        
        secondaryTable.reloadData()
        heightConstraint.constant = self.secondaryTable.contentSize.height
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return specificIngredientsDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "secondaryTableCell") as! ingredientsForEachShoopingListRecipeTableViewCell
        cell.secondaryLabel.text = specificIngredientsDataSource[indexPath.row]
        
        return cell
    }
    
   

}
