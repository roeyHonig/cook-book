//
//  ViewController.swift
//  cook-book
//
//  Created by hackeru on 3 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class MyRecipiesViewController: UIViewController , GIDSignInUIDelegate {
    var handle : AuthStateDidChangeListenerHandle!
   
    var signedUser: User?
    
    lazy var signInViewController: SignInViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    lazy var CurrentUserRecipiesViewController: CurrentUserRecipiesViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "CurrentUserRecipiesViewController") as! CurrentUserRecipiesViewController
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
   

    override func viewWillAppear(_ animated: Bool) {
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if  user != nil {
                // User is signed in.
                print("Hi, There Is A user!!!")
                print("The user name is: \(user!.displayName!)")
                self.signedUser = user
                self.setUpCurrentUserRecipiesViewController(user: self.signedUser!)
                self.signInViewController.view.isHidden = true
                self.CurrentUserRecipiesViewController.view.isHidden = false
                
            } else {
                // No user is signed in.
                print("No User, please sign in")
                self.signInViewController.view.isHidden = false
                self.CurrentUserRecipiesViewController.view.isHidden = true
            }
        }
        
        
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        Auth.auth().removeStateDidChangeListener(handle)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        GIDSignIn.sharedInstance().uiDelegate = self
        //GIDSignIn.sharedInstance().signIn()
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func setUpCurrentUserRecipiesViewController(user: User) {
        CurrentUserRecipiesViewController.GreetingLabel.text = "Hello \(user.displayName!)"
    }

}

