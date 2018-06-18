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

import FBSDKCoreKit
import FBSDKLoginKit


class SignInViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // ... facebook login sucess??
       
        if FBSDKAccessToken.current() == nil {
            return
        }
        
        let credential = FacebookAuthProvider.credential(withAccessToken: (FBSDKAccessToken.current().tokenString))
        
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
                if let error = error {
                    // ...
                    print("Error logging into firebase with facebook: \(error.localizedDescription)")
                    return
                }
                // User is signed in
                // ...
                
                print("Success Loggedin to firebase with facebook user: \(Auth.auth().currentUser!.displayName!)")
            }
            
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        //...
    }
    
   
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
        
        let faceBookLoginButton = FBSDKLoginButton()
        faceBookLoginButton.delegate = self
        self.view.addSubview(faceBookLoginButton)
        // position at center
        faceBookLoginButton.center = self.view.center
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
