//
//  favoriteRecipesViewController.swift
//  cook-book
//
//  Created by hackeru on 16 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//  currentlly just an example for loading url image

import UIKit
import SDWebImage

class favoriteRecipesViewController: UIViewController {
    
   
    @IBAction func presentingARecipy(_ sender: UIButton) {
        performSegue(withIdentifier: "toRecipyFromFavorites", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is RecipeDetailsViewController {
            // we're heading to see details of a Recipy
            let recpDetails = segue.destination as! RecipeDetailsViewController
            guard let cell = sender as! favoriteRecipesViewController else {return}
            guard let txt = cell.lab.text else {
                return
            }
            recpDetails.numofRecipie = txt
            recpDetails.recipeHeader = cell.recipeHeader
            
            // this is just a test to save a recipyHeader into the appeDalegate and acces it in another controller , Delete this!!!
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            appDelegate.sheredRecipyHeader = recpDetails.recipeHeader
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
       
        
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
