//
//  RecipiesViewController.swift
//  cook-book
//
//  Created by hackeru on 6 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//
// This are the recipies from the API //

import UIKit
import SDWebImage

class RecipiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate  {
    
    
    @IBOutlet weak var parentView: UIView! // consider to delete
    
    @IBOutlet weak var recipiesCollection: UICollectionView!
    let customBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.done, target: self, action: nil)
    @IBOutlet var recipyType: UISegmentedControl!
    
    var recipeImagesUrls : [String] = []
    var recipHeaderApi: RecipeHeaderAPI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        recipyType.selectedSegmentIndex = 0
        self.navigationItem.title = "Beef"
        self.navigationItem.backBarButtonItem = customBackButton
        self.navigationController?.delegate = self
        
        recipiesCollection.delegate = self
        recipiesCollection.dataSource = self
        
        retriveData(for: "Beef")
    }
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is RecipiesViewController  {
        let font = UIFont(name: "Helvetica", size: 42)! // TODO: it might be wise to provide some fallback fonts in case not all devices carry this
        navigationController.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: font]
            
        } else if viewController is RecipeDetailsViewController {
            let font = UIFont(name: "Helvetica", size: 12)! // TODO: it might be wise to provide some fallback fonts in case not all devices carry this
            navigationController.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: font]
        }
    }
 
    func retriveData(for table_col_value: String){
        getRecipeHeaderAPI(typeOfRecipyQuery: table_col_value) { (recipeHeaderApi) in
            self.recipeImagesUrls.removeAll()
            self.recipHeaderApi = recipeHeaderApi
            
            for recipe in recipeHeaderApi.rows {
                if let image = recipe.img {
                    self.recipeImagesUrls.append(image)
                }
                else {
                    self.recipeImagesUrls.append("defult")
                }
            }
            
            self.recipiesCollection.reloadData()
 
        }
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
        if recipeImagesUrls.count > 0 {
            return recipeImagesUrls.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleRecipe", for: indexPath) as! RecipeCollectionViewCell
        cell.lab.text = "\(indexPath.row)"
        cell.recipeHeader = self.recipHeaderApi?.rows[indexPath.row]
        
        if recipeImagesUrls.count > 0 {
            if recipeImagesUrls[indexPath.row] == "defult" {
                cell.recipeImage.image = #imageLiteral(resourceName: "icons8-cooking_pot_filled")
            } else {
                cell.recipeImage.sd_setImage(with: URL(string: recipeImagesUrls[indexPath.row]) , completed: nil)
            }
        }
        
        // change this values if you want to control the width of the yellow (background color for the entire cell) "frame" effect surronding the cell contentview
        cell.contentView.layoutMargins.bottom = 2
        cell.contentView.layoutMargins.top = 2
        cell.contentView.layoutMargins.left = 2
        cell.contentView.layoutMargins.right = 2
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is RecipeDetailsViewController {
            // a cell representing a recipy was clicked - that's the sender
            let recpDetails = segue.destination as! RecipeDetailsViewController
            let cell = sender as! RecipeCollectionViewCell
            guard let txt = cell.lab.text else {
                return
            }
            recpDetails.numofRecipie = txt
            recpDetails.recipeHeader = cell.recipeHeader
        }
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RecipeCollectionViewCell
        print(cell.lab.text!)
        // no need for "performe" because the segue is autmetically trigered upon selecting a cell
        //performSegue(withIdentifier: "toRecipyDetails", sender: cell)
    }
    */
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func toggelRecipyType(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            print("Beef")
            self.navigationItem.title = "Beef"
            retriveData(for: "Beef")
        case 1:
            print("Pork")
            self.navigationItem.title = "Pork"
            retriveData(for: "Pork")
        case 2:
            print("Poultry")
            self.navigationItem.title = "Poultry"
            retriveData(for: "Poultry")
        case 3:
            print("Seafood")
            self.navigationItem.title = "Seafood"
            retriveData(for: "Seafood")
        case 4:
            print("Vegetarian")
            self.navigationItem.title = "Vegetarian"
            retriveData(for: "Vegetarian")
        case 5:
            print("Side Dish")
            self.navigationItem.title = "Side Dish"
            retriveData(for: "Side_Dish")
        case 6:
            print("Salad")
            self.navigationItem.title = "Salad"
            retriveData(for: "Salad")
        case 7:
            print("Dessert")
            self.navigationItem.title = "Dessert"
            retriveData(for: "Dessert")
        default:
            print("don't know")
            self.navigationItem.title = "don't know"
        }
        
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
