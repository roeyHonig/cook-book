//
//  SideMenuViewController.swift
//  cook-book
//
//  Created by hackeru on 15 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit
import SDWebImage
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class SideMenuViewController: UIViewController {
    var currentUser: User?
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var sideMenuView: UIView!
    
    /*
    init(withFireBaseAuthUser usr: User?) {
        self.currentUser = usr
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    */
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileImage.sd_setImage(with: currentUser?.photoURL, completed: nil)
        
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
