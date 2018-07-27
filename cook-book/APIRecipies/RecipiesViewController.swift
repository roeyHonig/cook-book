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
import Firebase
import GoogleSignIn
import FBSDKCoreKit
import FBSDKLoginKit

class RecipiesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UINavigationControllerDelegate, GIDSignInUIDelegate  {
   
    // new
    
    lazy var mySideMenuController: SideMenuViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        var viewController = storyboard.instantiateViewController(withIdentifier: "SideMenuViewController") as! SideMenuViewController
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        self.navigationController!.addChildViewController(viewController)
        //viewController.view.frame = self.navigationController!.view.bounds
        //viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        
        self.navigationController?.view.addSubview(viewController.view)
        
        let tableViewConstraintTop = NSLayoutConstraint(item: viewController.view, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.navigationController?.view, attribute: NSLayoutAttribute.top , multiplier: 1, constant: 0)
        let tableViewConstraintBottom = NSLayoutConstraint(item: viewController.view, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: self.navigationController?.view, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
        let tableViewConstraintLeadingToTrailing = NSLayoutConstraint(item: viewController.view, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.navigationController?.view, attribute: NSLayoutAttribute.trailing , multiplier: 1, constant: 0)
        let tableViewConstraintwidth = NSLayoutConstraint(item: viewController.view, attribute: NSLayoutAttribute.width, relatedBy: .equal, toItem: self.navigationController?.view, attribute: NSLayoutAttribute.width , multiplier: 1, constant: 0)
        
        // assign the constraint to a coummon annssector
        self.navigationController?.view.addConstraint(tableViewConstraintTop)
        self.navigationController?.view.addConstraint(tableViewConstraintBottom)
        self.navigationController?.view.addConstraint(tableViewConstraintLeadingToTrailing)
        self.navigationController?.view.addConstraint(tableViewConstraintwidth)
        
        
        print("initinitinitnitnitnintintint")
        return viewController
    }()
    
    
    
    //-----------old
    
    @IBOutlet var sideMenuWidth: NSLayoutConstraint!
    @IBOutlet var sideMenuProfileImage: UIImageView!
    var isSideMenuShowing = false
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var framForProfileImage: UIImageView!
    @IBOutlet var displayNameLabel: UILabel!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var sideMenu: UIView!
    
    
    
    @IBOutlet var menuBarItem: UIBarButtonItem!
    @IBAction func pressingMenuBarItem(_ sender: UIBarButtonItem) {
        if isSideMenuShowing {
            // close the menue
            self.view.isUserInteractionEnabled = true
            UIView.animate(withDuration: 0.5, animations: {
                self.navigationController?.view.transform = CGAffineTransform.identity
                self.blurView.alpha = 0
                self.view.layoutIfNeeded()
            })
            
        } else {
            //open the menu
            self.view.isUserInteractionEnabled = false
            
            
            
            UIView.animate(withDuration: 0.5, animations: {
                
                // translate to the left the entire viewController
                self.navigationController?.view.transform = CGAffineTransform(translationX: -(100), y: 0)
                self.mySideMenuController.view.transform =  CGAffineTransform(translationX: -(0), y: 0) // just for the lazy var
                /*
                // add as subView the sideMenu view
                self.navigationController?.view.addSubview(self.mySideMenuController.view)
                // constraints
                let tableViewConstraintTop = NSLayoutConstraint(item: self.mySideMenuController.view, attribute: NSLayoutAttribute.top, relatedBy: .equal, toItem: self.navigationController?.view, attribute: NSLayoutAttribute.top , multiplier: 1, constant: 0)
                let tableViewConstraintBottom = NSLayoutConstraint(item: self.mySideMenuController.view, attribute: NSLayoutAttribute.bottom, relatedBy: .equal, toItem: self.parentView, attribute: NSLayoutAttribute.bottom , multiplier: 1, constant: 0)
                let tableViewConstraintLeadingToTrailing = NSLayoutConstraint(item: self.mySideMenuController.view, attribute: NSLayoutAttribute.leading, relatedBy: .equal, toItem: self.navigationController?.view, attribute: NSLayoutAttribute.trailing , multiplier: 1, constant: 0)
                
                // assign the constraint to a coummon annssector
                self.navigationController?.view.addConstraint(tableViewConstraintTop)
                self.navigationController?.view.addConstraint(tableViewConstraintBottom)
                self.navigationController?.view.addConstraint(tableViewConstraintLeadingToTrailing)
                */
                // blur View
                self.blurView.alpha = 0.8
                
                self.view.layoutIfNeeded()
            })
            
            
        }
        
        isSideMenuShowing = !isSideMenuShowing
        
    }
    
    var handle : AuthStateDidChangeListenerHandle!
    var signedUser: User?
    
    
    
    
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var recipiesCollection: UICollectionView!
    let myRefreshControl = UIRefreshControl()
    let customBackButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.done, target: self, action: nil)
    @IBOutlet var recipyType: UISegmentedControl!
    
    var recipHeaderApi: RecipeHeaderAPI? // will be used as the DataSource for the collection
    var recipes: [String: RecipeHeaderAPI?] = ["Beef":nil,"Pork" :nil,"Poultry":nil,"Seafood":nil,"Vegetarian":nil,"Side_Dish":nil,"Salad":nil,"Dessert":nil]
    var table_col_value = "Beef" // retrive data to which recipy type?
    var yet2bePreseedOnce: [String: Bool] = ["Beef":true,"Pork" :true,"Poultry":true,"Seafood":true,"Vegetarian":true,"Side_Dish":true,"Salad":true,"Dessert":true] // we want retrive from DB only when refresshing
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        // find out in which tabController item index you are
        print("hello, you are curenttly in index: \(self.tabBarController!.selectedIndex)")
        self.blurView.alpha = 0
        sideMenu.backgroundColor = UIColor(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0, alpha: 1)
        sideMenuWidth.constant = view.frame.size.width * 0.8 // side menu width
        
        initTheVisiabilityStateOfNavigationBarItemsLeftAndRightAndSideMenu()
        
        recipyType.selectedSegmentIndex = 0
        self.navigationItem.title = "Beef"
        self.navigationItem.backBarButtonItem = customBackButton
        self.navigationController?.delegate = self
        
        recipiesCollection.delegate = self
        recipiesCollection.dataSource = self
        myRefreshControl.addTarget(self, action: #selector(self.retriveData), for: UIControlEvents.valueChanged)
        recipiesCollection.refreshControl = myRefreshControl
        recipiesCollection.refreshControl?.beginRefreshing()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if  user != nil {
                // User is signed in.
                print("Hi, There Is A user and we are in index 0!!!")
                print("The user name is: \(user!.displayName!)")
                self.signedUser = user
                //self.signedUser!.photoURL
            } else {
                // No user is signed in.
                print("No User, please sign in, you're still at index 0")
               self.signedUser = nil
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        initTheVisiabilityStateOfNavigationBarItemsLeftAndRightAndSideMenu()
        
        retriveData()
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle)
        
        // close the menue
        self.view.isUserInteractionEnabled = true
        self.navigationController?.view.transform = CGAffineTransform.identity
        view.layoutIfNeeded()
        isSideMenuShowing = false
    }
   
    
    func initTheVisiabilityStateOfNavigationBarItemsLeftAndRightAndSideMenu() {
        if self.tabBarController!.selectedIndex == 1 {
            self.navigationItem.rightBarButtonItem = nil
        } else if signedUser != nil {
            
            self.navigationItem.rightBarButtonItem = menuBarItem
            // set the image
            /*
            sideMenuProfileImage.sd_setImage(with: signedUser!.photoURL, completed: nil)
            sideMenuProfileImage.layer.cornerRadius = sideMenuProfileImage.bounds.size.height / 2
            sideMenuProfileImage.clipsToBounds = true
             */
            self.blurView.alpha = 0
            // set the frame around the image
            /*
            framForProfileImage.layer.cornerRadius = sideMenuProfileImage.bounds.size.height / 2
            framForProfileImage.clipsToBounds = true
            // set display name & email
            displayNameLabel.text = signedUser!.displayName
            emailLabel.text = signedUser!.email
            */
        } else {
           self.navigationItem.rightBarButtonItem = nil
        }
    }
    
    
    
    
    
    func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        if viewController is RecipiesViewController  {
        let font = UIFont(name: "Helvetica", size: 36)! // TODO: it might be wise to provide some fallback fonts in case not all devices carry this
        navigationController.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: font]
            
        } else if viewController is RecipeDetailsViewController {
            let font = UIFont(name: "Helvetica", size: 12)! // TODO: it might be wise to provide some fallback fonts in case not all devices carry this
            navigationController.navigationBar.titleTextAttributes = [ NSAttributedStringKey.font: font]
        }
    }
 
    @objc func retriveData(){
        //TODO go imiddiatell to what we have so far and reload data
        self.recipHeaderApi = recipes[table_col_value]! // i'm assuming that table_col_value conforms to 1 of the predefined keys of the dictionary
        self.recipiesCollection.reloadData()
       
        // how many db results do we want and freom where to count them
        let limit = 3
        var offset = 0
        if let temp = self.recipHeaderApi {
            offset = temp.rows.count
        }
        
        // only retrive data from the DB if this is the 1st time the recipy item eas clicked or a refreshing task was sent by the user
        if (yet2bePreseedOnce[table_col_value]! || recipiesCollection.refreshControl!.isRefreshing) {
            getRecipeHeaderAPI(typeOfRecipyQuery: table_col_value, limit: limit, offset: offset) { (recipeHeaderApi , theRecipyType, stateCodeForTheTask) in
                if self.recipes[theRecipyType]! == nil {
                    // there is no data
                    self.recipes[theRecipyType]! = recipeHeaderApi
                } else {
                    // there is already some data, so we need to append
                    self.recipes[theRecipyType]!!.rows.append(contentsOf: recipeHeaderApi.rows)
                }
                
                self.recipHeaderApi = self.recipes[theRecipyType]!
                self.recipiesCollection.reloadData()
                self.recipiesCollection.refreshControl?.endRefreshing()
                self.yet2bePreseedOnce[theRecipyType]! = false
            }
        }
        
        
    }
   
    // we've manually configuered this func to return the CGSize we want for the cells in the collection view - and not the hardcoded dimension
    // in the storyboard IB
    // the cell frame will be of size with respect to the device screen size and there will be 2 cells columbs
    // the storyboard IB has 10 points margins bwteen cells and left \ righ margin, so 3 margins & 2 cells
    // total width = 3 * 10 + 2 * cell width
    // 0.8 was choosen as the Height \ Width ratio it looks very nice
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width - 30) / 2, height: 0.8 * (collectionView.frame.size.width - 30) / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let totalNumOfRecipesInCollection = recipHeaderApi?.rows.count else {
            return 0
        }
        return totalNumOfRecipesInCollection
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "singleRecipe", for: indexPath) as! RecipeCollectionViewCell
        cell.activityIndicator.startAnimating()
        cell.activityIndicator.hidesWhenStopped = true
        var totalNumOfRecipesInCollection = 0
        if let collectionArray = recipHeaderApi?.rows {totalNumOfRecipesInCollection = collectionArray.count}
        cell.lab.text = "DB id# \(self.recipHeaderApi?.rows[totalNumOfRecipesInCollection-indexPath.row - 1].id ?? 0)" // 0 is the defult value
        cell.recipeHeader = self.recipHeaderApi?.rows[totalNumOfRecipesInCollection-indexPath.row - 1]
        
       
        if let imgString = recipHeaderApi?.rows[totalNumOfRecipesInCollection-indexPath.row - 1].img {
            
            cell.recipeImage.sd_setImage(with: URL(string: imgString), completed: { (uiImage, error, sdimagecatchtype, url) in
                guard let err = error else {
                    cell.activityIndicator.stopAnimating()
                    cell.favoriteBtn.setBackgroundImage(#imageLiteral(resourceName: "icons8-favorites-steel"), for: .normal)
                    cell.favoriteBtn.alpha = 0.7
                    
                    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate, let myRecipyHeader = cell.recipeHeader else {
                        return
                    }
                    guard let isFavorite = appDelegate.defults.value(forKey: "\(myRecipyHeader.id)") as? Bool else {
                        return
                    }
                    if isFavorite {
                        cell.favoriteBtn.setBackgroundImage(#imageLiteral(resourceName: "icons8-favorites-red-marchino"), for: .normal)
                    }
                    return
                }
                print("error error loading picture: \(err)")
                cell.recipeImage.image = #imageLiteral(resourceName: "icons8-cooking_pot_filled")
            })
        } else {
            cell.recipeImage.image = #imageLiteral(resourceName: "icons8-cooking_pot_filled")
        }
        
        
        
        
        // change this values if you want to control the width of the yellow (background color for the entire cell) "frame" effect surronding the cell contentview
        cell.contentView.layoutMargins.bottom = 2
        cell.contentView.layoutMargins.top = 2
        cell.contentView.layoutMargins.left = 2
        cell.contentView.layoutMargins.right = 2
        
        cell.recipeImage.layer.cornerRadius = 8
        cell.recipeImage.clipsToBounds = true
        cell.contentView.layer.cornerRadius = 8
        cell.contentView.clipsToBounds = true
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
            
            // this is just a test to save a recipyHeader into the appeDalegate and acces it in another controller , Delete this!!!
            guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                return
            }
            appDelegate.sheredRecipyHeader = recpDetails.recipeHeader
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
            table_col_value = "Beef"

            retriveData()
        case 1:
            print("Pork")
            self.navigationItem.title = "Pork"
            table_col_value = "Pork"
            retriveData()
        case 2:
            print("Poultry")
            self.navigationItem.title = "Poultry"
            table_col_value = "Poultry"
            retriveData()
        case 3:
            print("Seafood")
            self.navigationItem.title = "Seafood"
             table_col_value = "Seafood"
            retriveData()
        case 4:
            print("Vegetarian")
            self.navigationItem.title = "Vegetarian"
            table_col_value = "Vegetarian"
            retriveData()
        case 5:
            print("Side Dish")
            self.navigationItem.title = "Side Dish"
            table_col_value = "Side_Dish"
            retriveData()
        case 6:
            print("Salad")
            self.navigationItem.title = "Salad"
            table_col_value = "Salad"
            retriveData()
        case 7:
            print("Dessert")
            self.navigationItem.title = "Dessert"
            table_col_value = "Dessert"
            retriveData()
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
