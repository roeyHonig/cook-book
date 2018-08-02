//
//  EditRecipeViewController.swift
//  cook-book
//
//  Created by hackeru on 20 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class EditRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
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
        
        return cell
    }
    

    
    @IBAction func saveTheNewRecipe(_ sender: UIBarButtonItem) {
        saveRecipeBasedOnTextFields()
    }
    
    @IBOutlet var recipePropertiesTableView: UITableView!
    
    var originalRecipeHeader: RecipeHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        recipePropertiesTableView.delegate = self
        recipePropertiesTableView.dataSource = self
        
    }

    func saveRecipeBasedOnTextFields(){
        print("let's revise this recipe")
        // TODO: we need to chack for invalid charcters
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

}
