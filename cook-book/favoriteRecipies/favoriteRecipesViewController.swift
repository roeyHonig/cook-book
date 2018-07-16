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
    
    
    lazy var detailsViewController: RecipeDetailsViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return viewController
        }
        guard let someRecipyHeader = appDelegate.sheredRecipyHeader else {
            return viewController
        }
        viewController.recipeHeader = someRecipyHeader
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
   
    @IBAction func presentingARecipy(_ sender: UIButton) {
        performSegue(withIdentifier: "toRecipyFromFavorites", sender: self)
        /*
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        guard let someRecipyHeader = appDelegate.sheredRecipyHeader else {
            return
        }
        print("Got SO Far")
        var recipeyFromFav = RecipeDetailsViewController()
        recipeyFromFav.recipeHeader = someRecipyHeader
        self.view.addSubview(recipeyFromFav)
        self.view.layoutIfNeeded()
 */
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // this is just a test to save a recipyHeader into the appeDalegate and acces it in another controller , Delete this!!!
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        guard let someRecipyHeader = appDelegate.sheredRecipyHeader else {
            return
        }
        
        
        
        if segue.destination is RecipeDetailsViewController /*segue.identifier! == "toRecipyFromFavorites"*/ {
            // we're heading to see details of a Recipy
            let recpDetails = segue.destination as! RecipeDetailsViewController
            guard let cell = sender as? favoriteRecipesViewController else {return}
           
            recpDetails.recipeHeader = someRecipyHeader
            recpDetails.sender = cell
            print("we got to the end of the prepere")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       self.detailsViewController.view.isHidden = false
        
    }

    
    func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        
        // uncomment the follwoing if you want the childViewController to populate the entire view of the parent viewController
        
        self.view.addSubview(childViewController.view)
        childViewController.view.frame = self.view.bounds
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        /*
         containerView.addSubview(childViewController.view)
         childViewController.view.frame = containerView.bounds
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
