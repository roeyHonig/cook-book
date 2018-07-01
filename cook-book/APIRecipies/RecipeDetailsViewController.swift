//
//  RecipeDetailsViewController.swift
//  cook-book
//
//  Created by hackeru on 8 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var testView: UIView!
    @IBOutlet var recipeHeaderView: UIView!
    
    @IBOutlet var backgroundImage: UIImageView!
    
    @IBOutlet var ingridentsBtnView: UIView!
    @IBOutlet var ingridentsTapGesture: UITapGestureRecognizer!
    @IBOutlet var directionsBtnView: UIView!
    @IBOutlet var directionsTapGesture: UITapGestureRecognizer!
    
    var ingridentsList: [[String?]?] = [
        ["garlic", "tyme" , "jucie" , "lemon"],
        ["potato" , "yam"],
        ["chicken" , "beak" , "grass" , "wheat" , "most important - have fun!"]
    ]
    var ingridentsHeaderTitles = ["for the marindae", "for the souch", "for the chicken"]
    var evenCellItem = true // a boolean for marking even cell of the ingridents table
    
    @IBOutlet var ingridentsTable: UITableView!
    
    
    
    
    var numofRecipie = ""
    
    var recipeHeader: RecipeHeader?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        ingridentsTapGesture.addTarget(self, action: #selector(showIngridents))
        ingridentsBtnView.addGestureRecognizer(ingridentsTapGesture)
        directionsTapGesture.addTarget(self, action: #selector(showDirections))
        directionsBtnView.addGestureRecognizer(directionsTapGesture)
        
        self.navigationItem.title = recipeHeader?.title! // TODO: configure this according to the title of the recipe
        
        ingridentsTable.delegate = self
        ingridentsTable.dataSource = self
    }
    
    @objc func showIngridents() {
        print("ingridents was pressed")
        
        /*
        // show the table view
        self.view.addSubview(ingridentsTable)
        
        // constraints
        //let tableViewConstraintTop = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: recipeHeaderView, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        //let tableViewConstraintBottom = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: backgroundImage, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        let tableViewConstraintLeft = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: recipeHeaderView, attribute: NSLayoutAttribute.trailing , multiplier: 1, constant: 0)
        let tableViewConstraintRight = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: recipeHeaderView, attribute: NSLayoutAttribute.leading , multiplier: 1, constant: 0)
        // Activate and assign the constraints
       NSLayoutConstraint.activate([/*tableViewConstraintTop, tableViewConstraintBottom,*/ tableViewConstraintLeft, tableViewConstraintRight])
        
        //self.view.addConstraint(tableViewConstraintTop)
        //self.view.addConstraint(tableViewConstraintBottom)
        self.view.addConstraint(tableViewConstraintLeft)
        self.view.addConstraint(tableViewConstraintRight)
 
         */
        
        // show the table view
        self.view.addSubview(testView)
        
        
        // constraints
        let tableViewConstraint1 = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: self.view, attribute: NSLayoutAttribute.width , multiplier: 0.5, constant: 0)
         let tableViewConstraint2 = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.height, relatedBy: .equal, toItem: self.view, attribute: NSLayoutAttribute.height , multiplier: 0.5, constant: 0)
        let tableViewConstraint3 = NSLayoutConstraint(item: testView, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: recipeHeaderView, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        
        // Activate and assign the constraints
        NSLayoutConstraint.activate([tableViewConstraint1, tableViewConstraint2, tableViewConstraint3 ])
        testView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.view.addConstraint(tableViewConstraint1)
        self.view.addConstraint(tableViewConstraint2)
        self.view.addConstraint(tableViewConstraint3)
        
        testView.frame.origin.x = 0
        
        
        
    }
    
    @objc func showDirections() {
        print("directions was pressed")
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        super.willMove(toParentViewController: parent)
        if parent == nil {
            // the back button was pressed - returning to the RecipesViewController
            let font = UIFont(name: "Helvetica", size: 42)! // TODO: it might be wise to provide some fallback fonts in case not all devices carry this
            self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: font]
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
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let IngridentsInThisSection = ingridentsList[section] else {
            return 0
        }
        return IngridentsInThisSection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingrident_cell") as! IngridientTableViewCell
        cell.ingridentDescription.text = ingridentsList[indexPath.section]?[indexPath.row]
        if evenCellItem {
            cell.contentView.backgroundColor = UIColor.gray
            evenCellItem = false
        } else {
           cell.contentView.backgroundColor = UIColor.white
            evenCellItem = true
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       return ingridentsHeaderTitles[section]
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
