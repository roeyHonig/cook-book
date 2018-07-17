//
//  favoriteRecipesViewController.swift
//  cook-book
//
//  Created by hackeru on 16 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//  currentlly just an example for loading url image

import UIKit
import SDWebImage

class favoriteRecipesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testTableDataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellToBeDequed") as! MyTestTableViewCell
        cell.testLabel.text = tableDataSource[indexPath.row].title
        cell.cellRecipyHeader = tableDataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! MyTestTableViewCell
        let detailsViewController2: RecipeDetailsViewController = {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            var viewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
            
            viewController.recipeHeader = cell.cellRecipyHeader
            return viewController
        }()
        self.navigationController?.pushViewController(detailsViewController2, animated: true)
    }
    
    
    @IBOutlet var testTable: UITableView!
    var testTableDataSource: [String] = []
    
    var tableDataSource: [RecipeHeader] = []
    
    @IBOutlet var parentView: UIView!
    
    @IBAction func pouplateTheParentViewWithADifrrentRecipy(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        detailsViewController.recipeHeader = appDelegate.firstRec
        //addViewControllerAsChildViewController(childViewController: detailsViewController)
        
        let detailsViewController2: RecipeDetailsViewController = {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            var viewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
            
            viewController.recipeHeader = appDelegate.secondRec
            return viewController
        }()
        self.navigationController?.pushViewController(detailsViewController2, animated: true)
    }
    
    @IBAction func pouplateTheParentView(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
       
        detailsViewController.recipeHeader = appDelegate.firstRec
        //addViewControllerAsChildViewController(childViewController: detailsViewController)
        
        let detailsViewController2: RecipeDetailsViewController = {
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            var viewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
            
            viewController.recipeHeader = appDelegate.firstRec
            return viewController
        }()
        self.navigationController?.pushViewController(detailsViewController2, animated: true)
        
    }
    
    var detailsViewController: RecipeDetailsViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        
        
        return viewController
    }()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        testTable.delegate = self
        testTable.dataSource = self
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // TODO: init datasource from the coreData
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        testTableDataSource.removeAll()
        tableDataSource = appDelegate.readCoreDataSavedFavoriteRecipies()
        for recpie in tableDataSource {
            if recpie.title != nil {
                testTableDataSource.append(recpie.title!)
            } else {
                testTableDataSource.append("blank")
            }
            
        }
        testTable.reloadData()
        
        appDelegate.firstRec = tableDataSource[0]
    }

    /*
    func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        
        // uncomment the follwoing if you want the childViewController to populate the entire view of the parent viewController
        
        self.view.addSubview(childViewController.view)
        childViewController.view.frame = self.view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
 
        
        //uncomment the follwoing if you want the childViewController to populate a certain View inside the parentController
        
        /*
         parentView.addSubview(childViewController.view)
         childViewController.view.frame = parentView.bounds
         childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        */
        
        childViewController.didMove(toParentViewController: self)
    }
    */
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
