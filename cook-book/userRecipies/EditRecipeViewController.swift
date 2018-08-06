//
//  EditRecipeViewController.swift
//  cook-book
//
//  Created by hackeru on 20 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class EditRecipeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UINavigationControllerDelegate {
    
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
    
        cell.parentView = self
        cell.mySection = indexPath.section
        cell.myRow = indexPath.row
    
        return cell
    }
    
    @IBOutlet var hideKeyboardBarBtn: UIBarButtonItem!
    
    @IBAction func hideKeyboard(_ sender: UIBarButtonItem) {
        hideTheKeyboard(inView: view)
    }
    
    @IBAction func saveTheNewRecipe(_ sender: UIBarButtonItem) {
        saveRecipeBasedOnTextFields()
    }
    
    @IBOutlet var recipePropertiesTableView: UITableView!
    
    var originalRecipeHeader: RecipeHeader?
    var theCurrentDataSource: [[String]] = [[],[],[],[],[],[],[],[],[],[],[]]
    
    let customBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.done, target: self, action: nil)
    
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
                //print("The DataSource says: " + theCurrentDataSource[i][j])
            }
        }
        
        // init the inital state of the dismiss keyboard bar btn
        hideKeyboardBarBtn.isEnabled = false
        
        // init the bacg bar btn
        self.navigationItem.backBarButtonItem = customBackButton
        self.navigationController?.delegate = self
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
        
        if !isValidURLString() {
            let invalidMassag: String = """
         Invalid characters found!
         Please avoid from using the following: " ' [ ] { }
         Our SQL Data Base don’t like that 😀
         """
            showAlertDialog(withMassage: invalidMassag)
            return
        }
        
        // TODO: cheack cooking times are Int
        // TODO: cheack to see no blank spaces in the ingrediets
        
        // construct a new Recipe
        let id = originalRecipeHeader!.id // it doesn't matter because we're going to delete this id and issiue a new one
        let title: String? = (theCurrentDataSource[0][0] != "" ? theCurrentDataSource[0][0] : nil)
        let img = originalRecipeHeader!.img
        let recipe_type = originalRecipeHeader!.recipe_type
        let prep_time: Int? = (theCurrentDataSource[1][0] != "" ? Int(theCurrentDataSource[1][0])  : nil)
        let cook_time: Int? = (theCurrentDataSource[2][0] != "" ? Int(theCurrentDataSource[2][0]) : nil)
        let serving: Int? = (theCurrentDataSource[3][0] != "" ? Int(theCurrentDataSource[3][0]) : nil)
        let author = originalRecipeHeader!.author
        let ingredient_header1: String? = (theCurrentDataSource[4][0] != "" ? theCurrentDataSource[4][0] : nil)
        let ingredient_header2: String? = (theCurrentDataSource[5][0] != "" ? theCurrentDataSource[5][0] : nil)
        let ingredient_header3: String? = (theCurrentDataSource[6][0] != "" ? theCurrentDataSource[6][0] : nil)
        let list1 :[String]? = (theCurrentDataSource[7].count > 0 ? theCurrentDataSource[7] : nil)
        let list2 :[String]? = (theCurrentDataSource[8].count > 0 ? theCurrentDataSource[8] : nil)
        let list3 :[String]? = (theCurrentDataSource[9].count > 0 ? theCurrentDataSource[9] : nil)
        let directions: String? = (theCurrentDataSource[10][0] != "" ? theCurrentDataSource[6][0] : nil)
        var newRevisedRecipe = RecipeHeader(id: id, title: title, img: img, recipe_type: recipe_type, prep_time: prep_time, cook_time: cook_time, serving: serving, author: author, ingredient_header1: ingredient_header1, ingredient_header2: ingredient_header2, ingredient_header3: ingredient_header3, list1: list1, list2: list2, list3: list3, directions: directions)
        newRevisedRecipe.user_recipe = true
        
        // delete the old recipe based on it's id , invoke the delete function used in the previus viewController
        // TODO: should also mind regrading removing from favirites if in there
        DeleteRecipeHeaderFromSQLTableAPI(id: -newRevisedRecipe.id){() in
            print("callback")
            // refresh the collection View
            for vc in self.navigationController!.viewControllers {
                if vc is RecipiesViewController {
                    let collectionOfRecipies = vc as! RecipiesViewController
                    collectionOfRecipies.refrashData()
                }
            }
            
            // write the new recipyHeader
            writeRevisedRecipeHeaderIntoSQLTableAPI(myRecipe: newRevisedRecipe, newAuthor: self.originalRecipeHeader!.author!) { (err , result, recipeyDetailsResultInInvalidURL) in
                if recipeyDetailsResultInInvalidURL {
                    print("Error, Cheack to make sure recipe details don't include URL invalid charcters!!!!")
                    // TODO: failure alert dialog
                    self.showAlertDialog(withMassage: "Ooops, something went wrong :(")
                } else if result.rowCount == nil {
                    print("seems the url went fine but no INSERT succefull")
                    // TODO: failure alert dialog
                    self.showAlertDialog(withMassage: "Ooops, something went wrong :(")
                } else {
                    print("i think we wrote it")
                    // TODO: sucess alert dialog
                    //self.showAlertDialog(withMassage: "Recipe added to your pesonal section :)")
                    self.showAlertDialogOfSucessInsertingRecipe(withMassage: "Recipe added to your pesonal section :)")
                    
                }
            }
            
        }
        
        
        
        
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
    
    func hideTheKeyboard(inView v: UIView) {
        v.subviews.forEach { (subView) in
            if let textView = subView as? UITextView{
                textView.resignFirstResponder()
            }
            else{
                hideTheKeyboard(inView: subView)
                
            }
        }
        
    }
    
    func showAlertDialog(withMassage str: String) {
        let alertController = UIAlertController(title: nil, message: str, preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true)
    }
    
    func showAlertDialogOfSucessInsertingRecipe(withMassage str: String) {
        let alertController = UIAlertController(title: nil, message: str, preferredStyle: UIAlertControllerStyle.alert)
        //let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        let confirmAction = UIAlertAction(title: "Ok", style: .default) { (uiAlertAction) in
            // refresh the recipe collection VC by invoking its refresh function
            // pop both view controllers - might need app delegate for that
            var collectionOfRecipies: RecipiesViewController?
            for vc in self.navigationController!.viewControllers {
                if vc is RecipiesViewController {
                    collectionOfRecipies = vc as! RecipiesViewController
                    collectionOfRecipies!.refrashData()
                    self.navigationController!.popToViewController(collectionOfRecipies!, animated: true)
                }
            }
        }
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true)
    }
    
    func isValidURLString() -> Bool {
        var invalidCharctersFound = false
        for i in 0...(theCurrentDataSource.count - 1) {
            for j in 0...(theCurrentDataSource[i].count - 1) {
                if theCurrentDataSource[i][j].contains("[") || theCurrentDataSource[i][j].contains("]") || theCurrentDataSource[i][j].contains("{") || theCurrentDataSource[i][j].contains("}") {
                    invalidCharctersFound = true
                }
                
                for v in theCurrentDataSource[i][j].unicodeScalars {
                    //print(v.value)
                    if v.value == 8220 || v.value == 8221 || v.value == 8216 || v.value == 8217 {
                        invalidCharctersFound = true
                    }
                }
            }
            
        }
        
        return !invalidCharctersFound
    }

}
