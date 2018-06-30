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
    var recipeHeader: RecipeHeader?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lab.text = "You selected recipiy# : \(numofRecipie)"
        // Do any additional setup after loading the view.
       // let font = UIFont(name: "Helvetica", size: 22)! // TODO: it might be wise to provide some fallback fonts in case not all devices carry this
      //  self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: font]
        self.navigationItem.title = recipeHeader?.title! // TODO: configure this according to the title of the recipe
        //self.navigationController!.navigationBar.topItem!.title = "Back"
       
       
    }
    
    override func willMove(toParentViewController parent: UIViewController?) {
        if parent == nil {
            print("yes finally")
            let font = UIFont(name: "Helvetica", size: 42)! // TODO: it might be wise to provide some fallback fonts in case not all devices carry this
            self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: font]
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        /*
        let font = UIFont(name: "Helvetica", size: 42)! // TODO: it might be wise to provide some fallback fonts in case not all devices carry this
        self.navigationController?.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: font]
 */
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
