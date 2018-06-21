//
//  RecipiesViewController.swift
//  cook-book
//
//  Created by hackeru on 6 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//
// This are the recipies from the API //

import UIKit

class RecipiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    
    @IBOutlet weak var parentView: UIView! // consider to delete
    @IBOutlet weak var titleRec: UIView!   // consider to delete
    @IBOutlet weak var typeOfRecipiesRec: UIView!  // consider to delete
    @IBOutlet weak var recipiesCollection: UICollectionView!
    
    
    
    let testarray = ["1" , "2" , "3" , "4" , "5" , "6" , "7" , "8" , "9"]   // needs to be retrived from a Database
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        recipiesCollection.delegate = self
        recipiesCollection.dataSource = self
        
        
        
       
    }
    
    // we've manually configuered this func to return the CGSize we want for the cells in the collection view - and not the hardcoded dimension
    // in the storyboard IB
    // the cell frame will be of size with respect to the device screen size and there will be 2 cells columbs
    // the storyboard IB has 10 points margins bwteen cells and left \ righ margin, so 3 margins & 2 cells
    // total width = 3 * 10 + 2 * cell width
    // 
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 30) / 2, height: (collectionView.frame.size.width - 30) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testarray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleRecipe", for: indexPath) as! RecipeCollectionViewCell
        cell.lab.text = testarray[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RecipeCollectionViewCell
        print(cell.lab.text!)
        // no need for "performe" because the segue is autmetically trigered upon selecting a cell
        //performSegue(withIdentifier: "toRecipyDetails", sender: cell)
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
