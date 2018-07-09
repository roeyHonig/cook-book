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
        recipesTableDataSource = ["tomato soup and alot of onions cause roey like onions very much" , "beef in poyke" , "chicked tenders"]
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
        //cell.showSecondaryTable()
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RecipesTableViewCell
        
        if cell.isSecondaryTableOpen {
            UIView.animate(withDuration:0.3, animations: {
                // animate stuff
                tableView.beginUpdates()
                cell.heightConstraint.constant = 0
                cell.layoutIfNeeded()
                tableView.endUpdates()
                
            }) { (bool) in
                // upon completion
                tableView.reloadData()
            }
            cell.isSecondaryTableOpen = false
        } else {
            UIView.animate(withDuration:0.3, animations: {
                // animate stuff
                tableView.beginUpdates()
                cell.heightConstraint.constant = 150
                cell.layoutIfNeeded()
                tableView.endUpdates()
                
            }) { (bool) in
                // upon completion
                tableView.reloadData()
            }
            cell.isSecondaryTableOpen = true
        }
        
        //cell.contentView.backgroundColor = UIColor.clear
       
        
 
        
       
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
