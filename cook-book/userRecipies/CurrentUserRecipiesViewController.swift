//
//  CurrentUserRecipiesViewController.swift
//  cook-book
//
//  Created by hackeru on 4 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//
// This is the user own recipies
// TODO: add a tableView

import UIKit
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class CurrentUserRecipiesViewController: UIViewController, GIDSignInUIDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    /*
     
     let detailsViewController2: RecipeDetailsViewController = {
     let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
     var viewController = storyboard.instantiateViewController(withIdentifier: "RecipeDetailsViewController") as! RecipeDetailsViewController
     
     viewController.recipeHeader = cell.cellRecipyHeader
     return viewController
     }()
     self.navigationController?.pushViewController(detailsViewController2, animated: true)
     
     */
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
