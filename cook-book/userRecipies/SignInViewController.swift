//
//  SignInViewController.swift
//  cook-book
//
//  Created by hackeru on 4 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//
// This is the sigin Screen users will see
// siging is requiered to manage users and present them thier own custom recipies
// TODO: copy the Any.Do login page

import UIKit
import Firebase
import GoogleSignIn

import FBSDKCoreKit
import FBSDKLoginKit


class SignInViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    @IBOutlet weak var customGoogleButtonIconImage: UIImageView!
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        // ... facebook login sucess??
       
        if FBSDKAccessToken.current() == nil {
            // Maybe the user hit cancel on the FB SDK
            // it's no error but the current loggedIn FB user is still nil and we can't proceed any further
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
        print("out!!!!!")
    }
    
   
    @IBOutlet weak var googleCustomSignInBtn: UIView!
    
    @IBOutlet var googleIconForCustomSignInBtn: UIImageView!
    
    
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
        googleSignInBtn.colorScheme  = GIDSignInButtonColorScheme.dark
        
        
        
        googleSignInBtn.frame = CGRect(x: 0, y: 500, width: view.frame.width, height: 50)
        //view.addSubview(googleSignInBtn)
        
        let faceBookLoginButton = FBSDKLoginButton()
        faceBookLoginButton.delegate = self
        self.view.addSubview(faceBookLoginButton)
        // position at center
        
        faceBookLoginButton.frame.size.height = googleCustomSignInBtn.frame.size.height
        faceBookLoginButton.frame.size.width = googleCustomSignInBtn.frame.size.width
        faceBookLoginButton.center = self.view.center
        
        let fbButtonText = NSAttributedString(string: "your FB text here")
        faceBookLoginButton.setAttributedTitle(fbButtonText, for: .normal)
        faceBookLoginButton.titleLabel?.font = UIFont(name: "System", size: 30)
        
        // init the google custom btn
        googleCustomSignInBtn.layer.cornerRadius = 8
        googleCustomSignInBtn.clipsToBounds = true
        googleIconForCustomSignInBtn.layer.cornerRadius = 4
        googleIconForCustomSignInBtn.clipsToBounds = true
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesBackButton = true // we don't need a back button for this screen
        navigationItem.title = "My cook-book"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // find out in which tabController item index you are
        print("hello, you are curenttly in index: \(self.tabBarController!.selectedIndex)")
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
