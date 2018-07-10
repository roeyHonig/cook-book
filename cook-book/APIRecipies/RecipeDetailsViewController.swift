//
//  RecipeDetailsViewController.swift
//  cook-book
//
//  Created by hackeru on 8 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//  TODO: just finsih the last icons and text in the recipe header

import UIKit
import CoreData
import SDWebImage

class RecipeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let sliderControlYPositions: [CGFloat] = [0.5 , 0.2 , 1]
    var currentSliderPositionIndex = 0
    
    @IBOutlet var sliderControllerBtnTapGesture: UITapGestureRecognizer!
    @IBOutlet var sliderPosition: NSLayoutConstraint!
    
    @IBOutlet var sliderControllerBtn: UIView!
    @IBOutlet var recipeHeaderView: UIView!
    
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet var ingridentsBtnView: UIView!
    @IBOutlet var ingridentsTapGesture: UITapGestureRecognizer!
    @IBOutlet var directionsBtnView: UIView!
    @IBOutlet var directionsTapGesture: UITapGestureRecognizer!
    
    var ingridentsList: [[String?]?] = [[],[],[]]
    var ingridentsHeaderTitles: [String?] = Array(repeating: nil, count: 3)
    var directionsText: String?
  
    
    @IBOutlet var ingridentsTable: UITableView!
    @IBOutlet var shopinglistContainer: UIView!
    @IBOutlet var addToShoppingListContainerHeight: NSLayoutConstraint!
    @IBOutlet var addToShoopingListView: UIView!
    @IBOutlet var addToShoppingListLabel: UILabel!
    
    @IBOutlet var addToShoopingIconImageView: UIImageView!
    
    @IBOutlet var distanceBetweenIconAndText: NSLayoutConstraint!
    
    @IBOutlet var constraintToEditInOrderToCenterTheAddToShopping: NSLayoutConstraint!
    
    @IBOutlet var addToShoppingListTapGesture: UITapGestureRecognizer!
    
    @IBOutlet var directionsUIView: UIView!
    
    
    @IBOutlet var directionsTextLabel: UILabel!
    
    
    @IBOutlet var sliderIconImage: UIImageView!
    
    
    
    @IBOutlet var ingridentsiconImage: UIImageView!
    
    
    @IBOutlet var directionsIconOmage: UIImageView!
    
    
    var numofRecipie = ""
    
    var recipeHeader: RecipeHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ingridentsTapGesture.addTarget(self, action: #selector(showIngridents))
        ingridentsBtnView.addGestureRecognizer(ingridentsTapGesture)
        directionsTapGesture.addTarget(self, action: #selector(showDirections))
        directionsBtnView.addGestureRecognizer(directionsTapGesture)
        sliderControllerBtnTapGesture.addTarget(self, action: #selector(slideAction))
        sliderControllerBtn.addGestureRecognizer(sliderControllerBtnTapGesture)
        addToShoppingListTapGesture.addTarget(self, action: #selector(addToShoppingList))
        addToShoopingListView.addGestureRecognizer(addToShoppingListTapGesture)
        
        // set title and background image
        self.navigationItem.title = recipeHeader?.title!
        if let imgString = recipeHeader?.img {backgroundImage.sd_setImage(with: URL(string: imgString), completed: nil)}
        
        ingridentsTable.delegate = self
        ingridentsTable.dataSource = self
        
        let yPosition = backgroundImage.frame.height * sliderControlYPositions[currentSliderPositionIndex] - recipeHeaderView.frame.height - sliderControllerBtn.frame.height
        sliderPosition.constant  = yPosition
        
        
        // very important!!!, otherwise the initial dimenstions becomes constraint themself and override our deseiered constraints
        ingridentsTable.translatesAutoresizingMaskIntoConstraints = false
        showIngridents()
        
        
        // center the icon + label of the "Add To Shopping List"
        print("The bounds max x is: \(addToShoppingListLabel.bounds.maxX)")
        print("The frame max x is: \(addToShoppingListLabel.frame.maxX)")
        print("The text width is: \(addToShoppingListLabel.intrinsicContentSize.width)")
        let frameWidth = backgroundImage.frame.size.width
        let textWidth = addToShoppingListLabel.intrinsicContentSize.width
        let distanceBetweenTextAndIcon = distanceBetweenIconAndText.constant
        let iconWidth = addToShoopingIconImageView.frame.size.width
        constraintToEditInOrderToCenterTheAddToShopping.constant = 0.5 * (frameWidth - (textWidth + distanceBetweenTextAndIcon + iconWidth))
        print("frameWidth: \(frameWidth) , textWidth: \(textWidth) , distanceBetweenTextAndIcon: \(distanceBetweenTextAndIcon), iconWidth: \(iconWidth), and finally: \(constraintToEditInOrderToCenterTheAddToShopping.constant)  ")
        
        sliderIconImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        // init from the db via previus VC
        guard let theCurrentRecipy = recipeHeader else {
            ingridentsHeaderTitles = ["for the marindae", "for the souch", "for the chicken"]
            ingridentsList = [
                ["garlic", "tyme" , "jucie" , "lemon"],
                ["potato" , "yam"],
                ["chicken" , "beak" , "grass" , "wheat" , "most important - have fun!"]
            ]
            return
        }
        ingridentsHeaderTitles = [theCurrentRecipy.ingredient_header1, theCurrentRecipy.ingredient_header2, theCurrentRecipy.ingredient_header3]
        ingridentsList = [theCurrentRecipy.list1 , theCurrentRecipy.list2, theCurrentRecipy.list3]
        directionsText = theCurrentRecipy.directions
        directionsTextLabel.text = directionsText
        
    }
    
    @objc func addToShoppingList() {
        print("adding ingridents")
        saveToCoreData()
        //showAlertDialog()
    }
    
    func showAlertDialog() {
        let alertController = UIAlertController(title: nil, message: "Ingredients have been added to your shopping list", preferredStyle: UIAlertControllerStyle.alert)
        let confirmAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(confirmAction)
        self.present(alertController, animated: true)
    }
    
    @objc func slideAction() {
        
        
        
        
        print("sliding commence")
        
        
        // we're allready lowered all the way and about to move up
        if self.sliderControlYPositions[self.currentSliderPositionIndex] == 1 {
            self.addToShoppingListContainerHeight.constant = 50
            self.sliderIconImage.image = #imageLiteral(resourceName: "icons8-expand_arrow_filled")
            self.sliderIconImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        }
        
        // we're at the top about to drop down
        if self.sliderControlYPositions[self.currentSliderPositionIndex] == 0.2 {
            self.sliderIconImage.image = #imageLiteral(resourceName: "icons8-menu_filled")
        }
        
        UIView.animate(withDuration: 1, animations: {
            // animate stuff
            
            // we're at the middle and about to move all the way up up
            if self.sliderControlYPositions[self.currentSliderPositionIndex] == 0.5 {
                self.sliderIconImage.transform = CGAffineTransform(rotationAngle: CGFloat.pi * 0)
            }
            
            if self.currentSliderPositionIndex == self.sliderControlYPositions.count - 1 {
                self.currentSliderPositionIndex = 0
            } else {
                self.currentSliderPositionIndex += 1
            }
            
            // we're about to lower all the way
            if self.sliderControlYPositions[self.currentSliderPositionIndex] == 1 {
                self.addToShoppingListContainerHeight.constant = 0
            }
            
            let yPosition = self.backgroundImage.frame.height * self.sliderControlYPositions[self.currentSliderPositionIndex] - self.recipeHeaderView.frame.height - self.sliderControllerBtn.frame.height
            self.sliderPosition.constant  = yPosition
            self.view.layoutIfNeeded()
        }) { (bool) in
            // upon animation completation
            print("sliding stoped")
            // if we've just finsihed beeing lowed all the way
            if self.sliderControlYPositions[self.currentSliderPositionIndex] == 1 {
                self.addToShoopingListView.alpha = 0
            } else {
                self.addToShoopingListView.alpha = 1
            }
            
            
        }
        
        
    }
    
    @objc func showIngridents() {
        directionsUIView.alpha = 0
        print("ingridents was pressed")
        directionsIconOmage.image = #imageLiteral(resourceName: "icons8-kitchen_steel")
        ingridentsiconImage.image = #imageLiteral(resourceName: "icons8-ingredients_spring")
        
        // show the table view
        self.view.addSubview(ingridentsTable)
        
        // constraints
        let tableViewConstraintTop = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: recipeHeaderView, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        let tableViewConstraintBottom = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: shopinglistContainer, attribute: NSLayoutAttribute.top , multiplier: 1, constant: 0)
        let tableViewConstraintLeft = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: recipeHeaderView, attribute: NSLayoutAttribute.trailing , multiplier: 1, constant: 0)
        let tableViewConstraintRight = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: recipeHeaderView, attribute: NSLayoutAttribute.leading , multiplier: 1, constant: 0)
       
       
        
        
        // assign the constraint to a coummon annssector
        self.view.addConstraint(tableViewConstraintTop)
        self.view.addConstraint(tableViewConstraintBottom)
        self.view.addConstraint(tableViewConstraintLeft)
        self.view.addConstraint(tableViewConstraintRight)
 
    }
    
    @objc func showDirections() {
        print("directions was pressed")
        directionsIconOmage.image = #imageLiteral(resourceName: "icons8-kitchen_spring")
        ingridentsiconImage.image = #imageLiteral(resourceName: "icons8-ingredients_steel")
        ingridentsTable.removeFromSuperview()
        directionsUIView.alpha = 1
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        if parent == nil {
            // the back button was pressed - returning to the RecipesViewController
            let font = UIFont(name: "Helvetica", size: 42)! // TODO: it might be wise to provide some fallback fonts in case not all devices carry this
            self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: font]
            backgroundImage.alpha = 0 // otherwise the image lingers
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let font = UIFont(name: "Helvetica", size: 12)! // TODO: it might be wise to provide some fallback fonts in case not all devices carry this
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: font]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ingridentsList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return ingridentsList[section].count
        guard let numOfIngridentsInThisSection = ingridentsList[section]?.count else {
            return 0
        }
        return numOfIngridentsInThisSection
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingrident_cell") as! IngridientTableViewCell
        cell.ingridentDescription.text = ingridentsList[indexPath.section]?[indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.gray
        } else {
           cell.contentView.backgroundColor = UIColor.white
        }
        
        /*
        // this was when i had only 1 label , so i appendded it the "•" and also made diffren colors
        // this is how you color part of a string diffrent from the other
        guard var newTextWithBulletain = cell.ingridentDescription.text else {
            return cell
        }
        newTextWithBulletain = "•    " + newTextWithBulletain
        // color only the "•" green
        let main_string = newTextWithBulletain
        let string_to_color = "•"
        let range = (main_string as NSString).range(of: string_to_color)
        let attribute = NSMutableAttributedString.init(string: main_string)
        attribute.addAttribute(NSAttributedStringKey.foregroundColor, value: UIColor.green, range: range)
        cell.ingridentDescription.attributedText = attribute
        */
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
       return ingridentsHeaderTitles[section]
    }
    
    func saveToCoreData() {
        var index = 1
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let myRecipeHeader = recipeHeader else {
                print("There was a problem")
                return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingList", in: managedContext)!
        
        if let listOfIngredients1 = myRecipeHeader.list1 {
            for ingrdientInList in listOfIngredients1 {
                let newEntery = NSManagedObject(entity: entity, insertInto: managedContext)
                let title = myRecipeHeader.title ?? ""
                newEntery.setValue(myRecipeHeader.id, forKeyPath: "idOfRecipe")
                newEntery.setValue(title, forKeyPath: "title")
                newEntery.setValue(ingrdientInList, forKeyPath: "ingredient")
                newEntery.setValue(index, forKeyPath: "index")
                index += 1
            }
        }
        
        if let listOfIngredients2 = myRecipeHeader.list2 {
            for ingrdientInList in listOfIngredients2 {
                let newEntery = NSManagedObject(entity: entity, insertInto: managedContext)
                let title = myRecipeHeader.title ?? ""
                newEntery.setValue(myRecipeHeader.id, forKeyPath: "idOfRecipe")
                newEntery.setValue(title, forKeyPath: "title")
                newEntery.setValue(ingrdientInList, forKeyPath: "ingredient")
                newEntery.setValue(index, forKeyPath: "index")
                index += 1
            }
        }
        
        if let listOfIngredients3 = myRecipeHeader.list3 {
            for ingrdientInList in listOfIngredients3 {
                let newEntery = NSManagedObject(entity: entity, insertInto: managedContext)
                let title = myRecipeHeader.title ?? ""
                newEntery.setValue(myRecipeHeader.id, forKeyPath: "idOfRecipe")
                newEntery.setValue(title, forKeyPath: "title")
                newEntery.setValue(ingrdientInList, forKeyPath: "ingredient")
                newEntery.setValue(index, forKeyPath: "index")
                index += 1
            }
        }
       
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        showAlertDialog()
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
