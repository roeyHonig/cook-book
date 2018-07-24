//
//  ShoppingListViewController.swift
//  cook-book
//
//  Created by hackeru on 25 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
// This ViewController present a TableView Inside A TableView gyhjkhjk

import UIKit
import CoreData
class ShoppingListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UINavigationControllerDelegate {
    
    @IBOutlet var mainTableView: UITableView!
    var shoppingListTable: [NSManagedObject] = []
    var recipesGlobalDataBaseNumbers: [Int?] = []
    var recipesTableDataSource: [String?] = []
    var ingridentsTableDataSource: [[String?]] = [[]]
    var ingridentsTableDataSourceInnerCircleImageAlpfa: [[Float?]] = [[]]
    var ingridentsTableDataSourceNumberOfTextLines: [[Int?]] = [[]]
    
    @IBAction func addCustomShoppingList(_ sender: UIBarButtonItem) {
        print("add was pressed")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.delegate = self
        
        // init tables data
        //TODO: needs to be retrived from the core data DB or shered instance
        recipesGlobalDataBaseNumbers = []
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
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        // did we actually changed anything , saved new recipy , update delete
        let areChangesPending = appDelegate.defults.value(forKey: "areCoreDataChangesPending") as! Bool
        
            appDelegate.defults.setValue(false, forKey: "areCoreDataChangesPending")
            
            for cell in (mainTableView.visibleCells as! [RecipesTableViewCell]) {
                if cell.isSecondaryTableOpen {
                  
                        mainTableView.beginUpdates()
                        cell.heightConstraint.constant = 0
                        cell.expendingArrowImageView.transform = CGAffineTransform.identity
                        cell.layoutIfNeeded()
                        mainTableView.endUpdates()
                  
                    cell.isSecondaryTableOpen = false
                }
            }
            
            
            
            
            shoppingListTable.removeAll()
            recipesGlobalDataBaseNumbers.removeAll()
            recipesTableDataSource.removeAll()
            ingridentsTableDataSource.removeAll()
            ingridentsTableDataSourceInnerCircleImageAlpfa.removeAll()
            ingridentsTableDataSourceNumberOfTextLines.removeAll()
            
            
            shoppingListTable = appDelegate.loadCoreData()
            var tmp = 0
            var tmpList: [String] = []
            var tmpListOfFloats: [Float] = []
            var tmpListOfIntegers: [Int] = []
            
            if shoppingListTable.count > 0 {
                // gather the data from coreData and put it into the tables data source arrays
                for i in 1...shoppingListTable.count {
                    if i != 1 && i != shoppingListTable.count {
                        // an item between the 1st and the last
                        // make inspectrion
                        if tmp != shoppingListTable[i-1].value(forKey: "idOfRecipe") as! Int {
                            // ok we've started a all new recipy shoppinglist, ok to append
                            ingridentsTableDataSource.append(tmpList) // appending the collected ingridents of the prevouslly recipy
                            ingridentsTableDataSourceInnerCircleImageAlpfa.append(tmpListOfFloats) // appending the collected ingridents of the prevouslly recipy cheacked status
                            ingridentsTableDataSourceNumberOfTextLines.append(tmpListOfIntegers) // appending the collected ingridents of the prevouslly recipy number of text lines per ingredient
                            recipesTableDataSource.append(shoppingListTable[i-1].value(forKey: "title") as! String)
                            recipesGlobalDataBaseNumbers.append(shoppingListTable[i-1].value(forKey: "idOfRecipe") as! Int)
                            tmpList = []
                            tmpListOfFloats = []
                            tmpListOfIntegers = []
                        }
                        tmpList.append(shoppingListTable[i-1].value(forKey: "ingredient") as! String)
                        tmpListOfFloats.append(shoppingListTable[i-1].value(forKey: "cheacked") as! Float)
                        tmpListOfIntegers.append(shoppingListTable[i-1].value(forKey: "ingredientNumTextLines") as! Int)
                        
                    }else if i == shoppingListTable.count{
                        // the last item
                        // let's append the ingridenyt and also let's append the collection ingredients collected so far
                        tmpList.append(shoppingListTable[i-1].value(forKey: "ingredient") as! String)
                        ingridentsTableDataSource.append(tmpList)
                        tmpListOfFloats.append(shoppingListTable[i-1].value(forKey: "cheacked") as! Float)
                        ingridentsTableDataSourceInnerCircleImageAlpfa.append(tmpListOfFloats)
                        tmpListOfIntegers.append(shoppingListTable[i-1].value(forKey: "ingredientNumTextLines") as! Int)
                        ingridentsTableDataSourceNumberOfTextLines.append(tmpListOfIntegers)
                        
                    } else {
                        // the 1st item
                        recipesTableDataSource.append(shoppingListTable[i-1].value(forKey: "title") as! String)
                        recipesGlobalDataBaseNumbers.append(shoppingListTable[i-1].value(forKey: "idOfRecipe") as! Int)
                        tmpList.append(shoppingListTable[i-1].value(forKey: "ingredient") as! String)
                        tmpListOfFloats.append(shoppingListTable[i-1].value(forKey: "cheacked") as! Float)
                        tmpListOfIntegers.append(shoppingListTable[i-1].value(forKey: "ingredientNumTextLines") as! Int)
                    }
                    tmp = shoppingListTable[i-1].value(forKey: "idOfRecipe") as! Int
                    
                }
            }
            
            mainTableView.reloadData()
        
        
        
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is ShoppingListViewController  {
            let font = UIFont(name: "Helvetica", size: 42)! // TODO: it might be wise to provide some fallback fonts in case not all devices carry this
            navigationController.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: font]
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
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "recipeNameCell") as! RecipesTableViewCell
        cell.theParentViewController = self
        cell.parentMainTableView = tableView
        cell.thisCellRowNumber = indexPath
            cell.label.text = recipesTableDataSource[indexPath.row]!
        cell.recipyGlobalDBID = recipesGlobalDataBaseNumbers[indexPath.row]!
            cell.specificIngredientsDataSource = ingridentsTableDataSource[indexPath.row]
        cell.specificIngredientsDataSourceInnerCircleAlpha = ingridentsTableDataSourceInnerCircleImageAlpfa[indexPath.row]
        cell.specificIngredientsDataSourceNumberOfTextLinesForTheIngredients = ingridentsTableDataSourceNumberOfTextLines[indexPath.row]
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
                    cell.expendingArrowImageView.transform = CGAffineTransform.identity
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
                    cell.expendingArrowImageView.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
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
