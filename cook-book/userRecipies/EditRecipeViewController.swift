//
//  EditRecipeViewController.swift
//  cook-book
//
//  Created by hackeru on 20 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class EditRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 11 // title , prep time, cook time, serving, ingredient header 1,2,3   list 1,2,3  directions
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let myRecipe = originalRecipeHeader else {
            return 0
        }
        
        if section == 7 {
            guard let mylist1 = myRecipe.list1 else {
                return 5
            }
            return mylist1.count + 5
        } else if section == 8 {
            guard let mylist2 = myRecipe.list2 else {
                return 5
            }
            return mylist2.count + 5
        } else if section == 9 {
            guard let mylist3 = myRecipe.list3 else {
                return 5
            }
            return mylist3.count + 5
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return titleOfSection(forIndex: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeProperty") as! RecipePropertiesTableViewCell
        guard let myRecipe = originalRecipeHeader else {
            return cell
        }
        
        //cell.propertyTextView.delegate = self
        cell.propertyTextView.text = theCurrentDataSource[indexPath.section][indexPath.row]
        
        cell.propertyTextView.translatesAutoresizingMaskIntoConstraints = false
        cell.propertyTextView.sizeToFit()
        cell.propertyTextView.isScrollEnabled = false
        
        cell.mySection = indexPath.section
        cell.myRow = indexPath.row
    
        return cell
    }
    
   
    @IBAction func hideKeyboard(_ sender: UIBarButtonItem) {
        hideTheKeyboard()
    }
    
    @IBAction func saveTheNewRecipe(_ sender: UIBarButtonItem) {
        saveRecipeBasedOnTextFields()
    }
    
    @IBOutlet var recipePropertiesTableView: UITableView!
    
    var originalRecipeHeader: RecipeHeader?
    var theCurrentDataSource: [[String]] = [[],[],[],[],[],[],[],[],[],[],[]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        recipePropertiesTableView.delegate = self
        recipePropertiesTableView.dataSource = self
        
        // init the dataSource
        for i in 0...10 {
            let maxJ = returnTheMaxIndexOfInnerArray(section: i)
            for j in 0...maxJ {
                theCurrentDataSource[i].append(returnTheCorrectText(forSection: i, andRow: j, fromTheRecipe: originalRecipeHeader!))
                print("The DataSource says: " + theCurrentDataSource[i][j])
            }
        }
        
        print("hello from edit")
        print("the title is: \(originalRecipeHeader?.title)")
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recipePropertiesTableView.reloadData()
    }
    
    /*
    func textViewDidEndEditing(_ textView: UITextView) {
     
        print("editing ended")
        print(textView.text)
    }
    */
    func saveRecipeBasedOnTextFields(){
        print("let's revise this recipe")
        // TODO: we need to chack for invalid charcters
        var invalidCharctersFound = false
        for i in 1...recipePropertiesTableView.numberOfSections {
            for j in 1...recipePropertiesTableView.numberOfRows(inSection: i - 1) {
                let tempIndexPath = IndexPath(row: j - 1, section: i - 1)
                let cell = recipePropertiesTableView.dequeueReusableCell(withIdentifier: "recipeProperty", for: tempIndexPath) as! RecipePropertiesTableViewCell
                print(cell.propertyTextView.text)
                if cell.propertyTextView.text.contains("[") || cell.propertyTextView.text.contains("]") || cell.propertyTextView.text.contains("{") || cell.propertyTextView.text.contains("}") || cell.propertyTextView.text.contains("""
                                                        "
                                                        """) || cell.propertyTextView.text.contains("'") {
                    invalidCharctersFound = true
                }
            }
        }
        
        if invalidCharctersFound {
            print("invalid charcter found")
            return
        } else {
            print("valid")
        }
        
        // if there are, alert dialog the usr and return
        // if all chacks out, construct a new Recipe
        // delete the old recipe based on it's id , invoke the delete function used in the previus viewController
        // write the new recipyHeader
        // refresh the recipe collection VC by invoking its refresh function
        // pop both view controllers - might need app delegate for that
    }
    
    func titleOfSection(forIndex i: Int) -> String? {
        switch i {
        case 0:
            return "Title:"
        case 1:
            return "Preparations Time:"
        case 2:
            return "Cooking Time:"
        case 3:
            return "Serving:"
        case 4:
            return "1st Ingredients List’s title:"
        case 5:
            return "2nd Ingredients List’s title:"
        case 6:
            return "3rd Ingredients List’s title:"
        case 7:
            return "1st Ingredients List"
        case 8:
            return "2nd Ingredients List:"
        case 9:
            return "3rd Ingredients List:"
        case 10:
            return "Directions:"
        default:
            return nil
        }
    }
    
    func returnTheCorrectText(forSection i: Int, andRow j: Int, fromTheRecipe recipe: RecipeHeader) -> String {
        switch i {
        case 0:
            guard let stringToReturn = recipe.title else {return ""}
            return stringToReturn
        case 1:
            guard let valueToReturn = recipe.prep_time else {return ""}
            return "\(valueToReturn)"
        case 2:
            guard let valueToReturn = recipe.cook_time else {return ""}
            return "\(valueToReturn)"
        case 3:
            guard let valueToReturn = recipe.serving else {return ""}
            return "\(valueToReturn)"
        case 4:
            guard let stringToReturn = recipe.ingredient_header1 else {return ""}
            return stringToReturn
        case 5:
            guard let stringToReturn = recipe.ingredient_header2 else {return ""}
            return stringToReturn
        case 6:
            guard let stringToReturn = recipe.ingredient_header3 else {return ""}
            return stringToReturn
        case 7:
            guard let ingredientsArray = recipe.list1 else {return ""}
            if ingredientsArray.count > j {
                return ingredientsArray[j]
            } else {
                return ""
            }
        case 8:
            guard let ingredientsArray = recipe.list2 else {return ""}
            if ingredientsArray.count > j {
                return ingredientsArray[j]
            } else {
                return ""
            }
        case 9:
            guard let ingredientsArray = recipe.list3 else {return ""}
            if ingredientsArray.count > j {
                return ingredientsArray[j]
            } else {
                return ""
            }
        case 10:
            guard let stringToReturn = recipe.directions else {return ""}
            return stringToReturn
        default:
            return ""
        }
    }
    
    func returnTheMaxIndexOfInnerArray(section: Int) -> Int {
        guard let myRecipe = originalRecipeHeader else {
            return -1
        }
        
        if section == 7 {
            guard let mylist1 = myRecipe.list1 else {
                return 4
            }
            return mylist1.count + 4
        } else if section == 8 {
            guard let mylist2 = myRecipe.list2 else {
                return 4
            }
            return mylist2.count + 4
        } else if section == 9 {
            guard let mylist3 = myRecipe.list3 else {
                return 4
            }
            return mylist3.count + 4
        } else {
            return 0
        }
    }
    
    func hideTheKeyboard() {
        for v in view.subviews {
            if v is UITextView {
                v.resignFirstResponder()
            }
            if v.subviews.count > 0 {
                hideTheKeyboard()
            }
        }
    }

}
