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
        if section == 7 {
            
        } else if section == 8 {
            
        } else if section == 9 {
            
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
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

}
