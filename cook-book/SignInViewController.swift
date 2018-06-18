//
//  SignInViewController.swift
//  cook-book
//
//  Created by hackeru on 4 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class SignInViewController: UIViewController, GIDSignInUIDelegate {
   
    @IBAction func signInWithCustomButtone(_ sender: UITapGestureRecognizer) {
        print("custome Button!!!!!")
        GIDSignIn.sharedInstance().signIn()
    }
    
    
    @IBAction func signIn(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //SignIn Button
        let googleSignInBtn = GIDSignInButton()
        
        googleSignInBtn.frame = CGRect(x: 0, y: 500, width: view.frame.width, height: 50)
        view.addSubview(googleSignInBtn)
        
        
    }

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
