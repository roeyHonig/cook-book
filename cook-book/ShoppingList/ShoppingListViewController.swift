//
//  ShoppingListViewController.swift
//  cook-book
//
//  Created by hackeru on 25 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
// This ViewController present a TableView Inside A TableView gyhjkhjk

import UIKit

class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mainTableView: UITableView!
    
    var recipesTableDataSource: [String?] = []
    var ingridentsTableDataSource: [[String?]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // init tables data
        //TODO: needs to be retrived from the core data DB or shered instance
        recipesTableDataSource = ["tomato soup" , "beef in poyke" , "chicked tenders"]
        ingridentsTableDataSource = [
            ["tomatop", "powder soup", "onions", "garlic", "bazeil"],
            ["beef", "lemon", "garlic"],
            ["chicken", "peprika"]
        ]
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipesTableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeNameCell") as! RecipesTableViewCell
        cell.label.text = recipesTableDataSource[indexPath.row]
        
        
        
        let myFrame = CGRect(origin: cell.insideTableContainer.frame.origin, size: CGSize(width: cell.label.frame.width/* - cell.label.layoutMargins.left - cell.label.layoutMargins.right*/, height: 50))
        let testView = UIView(frame: myFrame)
        testView.backgroundColor = UIColor.blue
        
        //cell.insideTableContainer.addSubview(testView)
        cell.contentView.addSubview(testView)
        
        // constraints
        let tableViewConstraintTop = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: cell.label, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        let tableViewConstraintBottom = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: cell.bottomSpacer, attribute: NSLayoutAttribute.top , multiplier: 1, constant: 0)
        let tableViewConstraintLeft = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: cell.label, attribute: NSLayoutAttribute.trailing , multiplier: 1, constant: 0)
        let tableViewConstraintRight = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: cell.label, attribute: NSLayoutAttribute.leading , multiplier: 1, constant: 0)
        
        // assign the constraint to a coummon annssector
        cell.contentView.addConstraint(tableViewConstraintTop)
        cell.contentView.addConstraint(tableViewConstraintBottom)
        cell.contentView.addConstraint(tableViewConstraintLeft)
        cell.contentView.addConstraint(tableViewConstraintRight)
 
        
        return cell
    }
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
