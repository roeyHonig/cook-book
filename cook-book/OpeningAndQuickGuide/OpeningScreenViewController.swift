//
//  OpeningScreenViewController.swift
//  cook-book
//
//  Created by hackeru on 6 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class OpeningScreenViewController: UIViewController {

    @IBOutlet var backgroungView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        UIView.animate(withDuration: 3, animations: {
            // animate stuff
            self.backgroungView.alpha = 1
        }) { (bool) in
            //upon compleation
            print("Congrats, animation is over")
            self.performSegue(withIdentifier: "startApp", sender: self)
        }
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
