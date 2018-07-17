//
//  favoriteRecipesViewController.swift
//  cook-book
//
//  Created by hackeru on 16 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//  currentlly just an example for loading url image

import UIKit
import SDWebImage

class favoriteRecipesViewController: UIViewController {
    
    @IBOutlet var parentView: UIView!
    
    
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
        
       //self.detailsViewController.view.isHidden = false
        
    }

    
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
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
