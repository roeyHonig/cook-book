//
//  ShoppingListViewController.swift
//  cook-book
//
//  Created by hackeru on 25 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
// This ViewController present a TableView Inside A TableView gyhjkhjk

import UIKit
import CoreData
class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var mainTableView: UITableView!
    var shoppingListTable: [NSManagedObject] = []
    var recipesTableDataSource: [String?] = []
    var ingridentsTableDataSource: [[String?]] = [[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // init tables data
        //TODO: needs to be retrived from the core data DB or shered instance
        recipesTableDataSource = ["tomato soup and alot of onions cause roey like onions very much starting now tomato soup and alot of onions cause roey like onions very much" , "beef in poyke" , "chicked tenders"]
        ingridentsTableDataSource = [
            ["tomatop", "powder soup", "onions", "garlic", "bazeil"],
            ["beef", "lemon", "garlic"],
            ["chicken", "peprika"]
        ]
        
        
        
        
        mainTableView.delegate = self
        mainTableView.dataSource = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingList")
        let descriptor = NSSortDescriptor(key: "index", ascending: true)
        let descriptors = [descriptor]
        fetchRequest.sortDescriptors = descriptors
        do {
            shoppingListTable = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for ingredient in shoppingListTable {
            
            print("Recipy#: \(String(describing: ingredient.value(forKey: "idOfRecipe")))")
            print("The title: \(String(describing: ingredient.value(forKey: "title")))")
            print("ingrident is: \(String(describing: ingredient.value(forKey: "ingredient")))")
            print("The index is: \(String(describing: ingredient.value(forKey: "index")))")
        }
        
        
        
    }
    
   

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView.tag == 100 {
        
            return recipesTableDataSource.count
        }
        else {
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView.tag == 100 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeNameCell") as! RecipesTableViewCell
            cell.label.text = recipesTableDataSource[indexPath.row]
            cell.specificIngredientsDataSource = ingridentsTableDataSource[indexPath.row]
            //cell.showSecondaryTable()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "secondaryTableCell") as! ingredientsForEachShoopingListRecipeTableViewCell
            cell.secondaryLabel.text = "roey"
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 100 {
            let cell = tableView.cellForRow(at: indexPath) as! RecipesTableViewCell
            tableView.deselectRow(at: indexPath, animated: true)
            
            if cell.isSecondaryTableOpen {
                UIView.animate(withDuration:0.3, animations: {
                    // animate stuff
                    tableView.beginUpdates()
                    cell.heightConstraint.constant = 0
                    cell.layoutIfNeeded()
                    tableView.endUpdates()
                    
                }) { (bool) in
                    // upon completion
                }
                cell.isSecondaryTableOpen = false
            } else {
                
            
                UIView.animate(withDuration:0.3, animations: {
                    // animate stuff
                    tableView.beginUpdates()
                    cell.heightConstraint.constant = cell.secondaryTable.contentSize.height
                    cell.layoutIfNeeded()
                    tableView.endUpdates()
                    
                }) { (bool) in
                    // upon completion
                }
                cell.isSecondaryTableOpen = true
            }
            
            
        }
       
        
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
