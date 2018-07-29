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

class CurrentUserRecipiesViewController: UIViewController, GIDSignInUIDelegate, UINavigationControllerDelegate {
    
    var myHandle : AuthStateDidChangeListenerHandle!
    var mySignedUser: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.delegate = self
       
        
        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myHandle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if  user != nil {
                self.mySignedUser = user
                let myRecipiesViewController: RecipiesViewController = {
                    let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                    var viewController = storyboard.instantiateViewController(withIdentifier: "RecipiesViewController") as! RecipiesViewController
                    
                    return viewController
                }()
                self.navigationController?.pushViewController(myRecipiesViewController, animated: true)
            } else {
                // No user is signed in.
                self.mySignedUser = nil
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(myHandle)
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
