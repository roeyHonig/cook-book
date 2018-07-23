//
//  QuicGuidCookViewController.swift
//  cook-book
//
//  Created by hackeru on 11 Av 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class QuicGuidCookViewController: UIViewController {

    @IBOutlet var parentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = UIColor.lightGray
        parentView.backgroundColor = UIColor.lightGray
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
