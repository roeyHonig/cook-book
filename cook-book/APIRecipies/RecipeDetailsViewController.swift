//
//  RecipeDetailsViewController.swift
//  cook-book
//
//  Created by hackeru on 8 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import UIKit

class RecipeDetailsViewController: UIViewController {
    var numofRecipie = ""
    @IBOutlet weak var lab: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lab.text = "You selected recipiy# : \(numofRecipie)"
        // Do any additional setup after loading the view.
        self.navigationItem.title = "roey" // TODO: configure this according to the title of the recipe
        
       
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
