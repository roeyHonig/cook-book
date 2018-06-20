//
//  RecipiesViewController.swift
//  cook-book
//
//  Created by hackeru on 6 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//
// This are the recipies from the API

import UIKit

class RecipiesViewController: UIViewController {
    @IBOutlet weak var recta: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        guard let width = recta.superview?.frame.size.width , let _ = recta.superview?.frame.size.height  else {return}
        
        let origPoint = 0.5 * width
        recta.frame.origin.x = origPoint
        
       
        
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
