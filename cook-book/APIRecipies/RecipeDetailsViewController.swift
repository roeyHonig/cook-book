//
//  RecipeDetailsViewController.swift
//  cook-book
//
//  Created by hackeru on 8 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

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
    
    var ingridentsList: [[String?]] = [[],[],[]]
    
    
    var ingridentsHeaderTitles: [String?] = Array(repeating: nil, count: 3)
  
    
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
        sliderControllerBtnTapGesture.addTarget(self, action: #selector(slideAction))
        sliderControllerBtn.addGestureRecognizer(sliderControllerBtnTapGesture)
        
        self.navigationItem.title = recipeHeader?.title! // TODO: configure this according to the title of the recipe
        
        ingridentsTable.delegate = self
        ingridentsTable.dataSource = self
        
        let yPosition = backgroundImage.frame.height * sliderControlYPositions[currentSliderPositionIndex] - recipeHeaderView.frame.height - sliderControllerBtn.frame.height
        sliderPosition.constant  = yPosition
        
        // TODO: init should come from the db via previus VC
        ingridentsHeaderTitles = ["for the marindae", "for the souch", "for the chicken"]
        ingridentsList = [
                         ["garlic", "tyme" , "jucie" , "lemon"],
                         ["potato" , "yam"],
                         ["chicken" , "beak" , "grass" , "wheat" , "most important - have fun!"]
         ]
        
    }
    
    @objc func slideAction() {
        print("sliding commence")
        UIView.animate(withDuration: 1) {
            // animate stuff
            if self.currentSliderPositionIndex == self.sliderControlYPositions.count - 1 {
                self.currentSliderPositionIndex = 0
            } else {
                self.currentSliderPositionIndex += 1
            }
            
            let yPosition = self.backgroundImage.frame.height * self.sliderControlYPositions[self.currentSliderPositionIndex] - self.recipeHeaderView.frame.height - self.sliderControllerBtn.frame.height
            self.sliderPosition.constant  = yPosition
            self.view.layoutIfNeeded()
        }
        
        
    }
    
    @objc func showIngridents() {
        print("ingridents was pressed")
        
        // show the table view
        self.view.addSubview(ingridentsTable)
        
        // constraints
        let tableViewConstraintTop = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: recipeHeaderView, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        let tableViewConstraintBottom = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: backgroundImage, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        let tableViewConstraintLeft = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.trailing, relatedBy: .equal, toItem: recipeHeaderView, attribute: NSLayoutAttribute.trailing , multiplier: 1, constant: 0)
        let tableViewConstraintRight = NSLayoutConstraint(item: ingridentsTable, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: recipeHeaderView, attribute: NSLayoutAttribute.leading , multiplier: 1, constant: 0)
       
       
        // very important!!!, otherwise the initial dimenstions becomes constraint themself and override our deseiered constraints
        ingridentsTable.translatesAutoresizingMaskIntoConstraints = false
        
        // assign the constraint to a coummon annssector
        self.view.addConstraint(tableViewConstraintTop)
        self.view.addConstraint(tableViewConstraintBottom)
        self.view.addConstraint(tableViewConstraintLeft)
        self.view.addConstraint(tableViewConstraintRight)
 
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
        return ingridentsList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingrident_cell") as! IngridientTableViewCell
        cell.ingridentDescription.text = ingridentsList[indexPath.section][indexPath.row]
        
        if indexPath.row % 2 == 0 {
            cell.contentView.backgroundColor = UIColor.gray
        } else {
           cell.contentView.backgroundColor = UIColor.white
        }
        
        guard var newTextWithBulletain = cell.ingridentDescription.text else {
            return cell
        }
        newTextWithBulletain = "• " + newTextWithBulletain
        cell.ingridentDescription.text = newTextWithBulletain
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
