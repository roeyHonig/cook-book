//
//  RecipeDetailsViewController.swift
//  cook-book
//
//  Created by hackeru on 8 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
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
