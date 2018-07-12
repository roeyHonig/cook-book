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
        recipesTableDataSource = [] /*["tomato soup and alot of onions cause roey like onions very much starting now tomato soup and alot of onions cause roey like onions very much" , "beef in poyke" , "chicked tenders"]*/
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
        
        shoppingListTable.removeAll()
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingList")
        let descriptor1 = NSSortDescriptor(key: "idOfRecipe", ascending: true)
        let descriptor2 = NSSortDescriptor(key: "index", ascending: true)
        let descriptors = [descriptor1, descriptor2]
        fetchRequest.sortDescriptors = descriptors
        do {
            shoppingListTable = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        var tmp = 0
        var tmpList: [String] = []
        recipesTableDataSource.removeAll()
        ingridentsTableDataSource.removeAll()
        if shoppingListTable.count > 0 {
            for i in 1...shoppingListTable.count {
                // an item between the 1st and the last
                if i != 1 && i != shoppingListTable.count {
                        // make inspectrion
                        if tmp != shoppingListTable[i-1].value(forKey: "idOfRecipe") as! Int {
                            // ok we've started a all new recipy shoppinglist, ok to append
                            ingridentsTableDataSource.append(tmpList) // appending the collected ingridents of the prevouslly recipy
                            recipesTableDataSource.append(shoppingListTable[i-1].value(forKey: "title") as! String)
                            tmpList = []
                            tmpList.append(shoppingListTable[i-1].value(forKey: "ingredient") as! String)
                        } else {
                            // we are in the same recipy but let's append the ingridenyts
                            tmpList.append(shoppingListTable[i-1].value(forKey: "ingredient") as! String)
                        }
                 print ("in between")
                }else if i == shoppingListTable.count{
                    // the last item
                    // let's append the ingridenyt and also let's append the collection ingredients collected so far
                    tmpList.append(shoppingListTable[i-1].value(forKey: "ingredient") as! String)
                    ingridentsTableDataSource.append(tmpList)
                    print("we were here")
            
                } else {
                    // the 1st item
                    print ("the 1st item")
                    recipesTableDataSource.append(shoppingListTable[i-1].value(forKey: "title") as! String)
                    tmpList.append(shoppingListTable[i-1].value(forKey: "ingredient") as! String)
                }
                tmp = shoppingListTable[i-1].value(forKey: "idOfRecipe") as! Int
                print("iteration, the count is: \(shoppingListTable.count), i is: \(i)")
            }
        }
        
        
        
        print(recipesTableDataSource)
        
        mainTableView.reloadData()
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
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeNameCell") as! RecipesTableViewCell
        cell.theParentViewController = self
        cell.parentMainTableView = tableView
        cell.thisCellRowNumber = indexPath
            cell.label.text = recipesTableDataSource[indexPath.row]
            cell.specificIngredientsDataSource = ingridentsTableDataSource[indexPath.row]
            cell.secondaryTable.reloadData()
            //cell.showSecondaryTable()
            //tableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableViewScrollPosition.bottom)
            return cell
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.tag == 100 {
            print("A cell was pressed")
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
            self.view.layoutIfNeeded()
            
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
