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
   
    @IBOutlet var oneTimeActivityIndicator: UIActivityIndicatorView!
    
    @IBOutlet var refreshBtn: UIBarButtonItem!
    
    @IBAction func refrshingTheDataSource(_ sender: UIBarButtonItem) {
        refrashData()
    }
    
    @IBAction func signingOut(_ sender: UIButton) {
        print("byeeeee")
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            GIDSignIn.sharedInstance().signOut()
            FBSDKLoginManager().logOut()
            print("signed out?")
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
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
            UIView.animate(withDuration: 0.5, animations: {
                self.closeTheSideMenu()
            })
            
        } else {
            //open the menu
            self.parentView.isUserInteractionEnabled = false
            UIView.animate(withDuration: 0.5, animations: {
            // translate to the left the entire viewController
            self.parentView.transform = CGAffineTransform(translationX: -(self.sideMenu.bounds.width), y: 0)
            // blur View
            self.blurView.alpha = 0.8
            
            self.view.layoutIfNeeded()
            })
            
            
        }
        // toggle state
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
        var s1 = preperForSql(TheFollwingStringArray: ["parcelly, in salt","lymes, cut in half","some, good stuff"])
        print(s1)
        
        self.blurView.alpha = 0
        sideMenu.backgroundColor = UIColor(red: 235 / 255.0, green: 235 / 255.0, blue: 235 / 255.0, alpha: 1)
        
        recipyType.selectedSegmentIndex = 0
        self.navigationItem.title = "Beef"
        self.navigationItem.backBarButtonItem = customBackButton
        self.navigationController?.delegate = self
        
        recipiesCollection.delegate = self
        recipiesCollection.dataSource = self
        myRefreshControl.addTarget(self, action: #selector(self.retriveData), for: UIControlEvents.valueChanged)
        recipiesCollection.refreshControl = myRefreshControl
        recipiesCollection.refreshControl?.beginRefreshing()
        
        // init the one time activity indicator, otherwisw , there is no indicatio, like in the refresegBegins, that something is appeaning
        oneTimeActivityIndicator.hidesWhenStopped = true
        oneTimeActivityIndicator.startAnimating()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // a listener for when the status of a user changes (will also cheack 1 time when initaliazed)
        handle = Auth.auth().addStateDidChangeListener { (auth, user) in
            if  user != nil {
                // User is signed in.
                print("Hi, There Is A user and we are in index \(self.tabBarController!.selectedIndex)!!!")
                print("The user name is: \(user!.displayName!)")
                self.signedUser = user
                self.addTheSideMenuAsSubView(withTheFollowingSignedUser: self.signedUser!)
                self.initTheVisiabilityStateOfNavigationBarItemsLeftAndRightAndSideMenu()
                self.retriveData()
            } else {
                // No user is signed in.
                self.closeTheSideMenu()
                self.isSideMenuShowing = false
                print("No User, please sign in, you're still at index 0")
                self.signedUser = nil
                self.initTheVisiabilityStateOfNavigationBarItemsLeftAndRightAndSideMenu()
                self.retriveData()
            }
        }
        
        // cheack to see if a diffrent user has just signed in
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        if appDelegate.defults.value(forKey: "haveWeJustFinishLoginProcessSuccefully") as! Bool {
            refrashDataOneTimeWheneverANewUserJustSignedIn()
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Auth.auth().removeStateDidChangeListener(handle)
        
        closeTheSideMenu()
        isSideMenuShowing = false
        self.blurView.alpha = 0
    }
   
    
    func initTheVisiabilityStateOfNavigationBarItemsLeftAndRightAndSideMenu() {
        if signedUser != nil {
            self.navigationItem.rightBarButtonItem = menuBarItem
            self.blurView.alpha = 0
            if tabBarController!.selectedIndex == 3 {self.navigationItem.leftBarButtonItem = refreshBtn} else {self.navigationItem.leftBarButtonItem = nil}
        } else {
           self.navigationItem.rightBarButtonItem = nil
            self.navigationItem.leftBarButtonItem = nil
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
        navigationItem.hidesBackButton = true // we don't need a back button for this screen
    }
 
    @objc func retriveData(){
        // go imiddiatell to what we have so far and reload data
        self.recipHeaderApi = recipes[table_col_value]! // i'm assuming that table_col_value conforms to 1 of the predefined keys of the dictionary
        self.recipiesCollection.reloadData()
       
        // how many db results do we want and freom where to count them
        let limit = 8
        var offset = 0
        if let temp = self.recipHeaderApi {
            offset = temp.rows.count
        }
        
        // cheack are we in the API recipes? or in a user recipes?, so we know for which table in the DB to query
        var tableName = "recipes_draft2"
        var autor: String?// the email representing which user owns a particular recipy
        
        if self.tabBarController?.selectedIndex == 3 {
            tableName = "recipes_of_users"
            if signedUser != nil {
                let userInfo = Auth.auth().currentUser!.providerData[0]
                let signedUserEmail = userInfo.email
                autor = signedUserEmail
            } 
        }
        
        
        // only retrive data from the DB if this is the 1st time the recipy item eas clicked or a refreshing task was sent by the user
        if (yet2bePreseedOnce[table_col_value]! || recipiesCollection.refreshControl!.isRefreshing) {
            getRecipeHeaderAPI(nameOfDBTable: tableName, nameOfAutor: autor, typeOfRecipyQuery: table_col_value, limit: limit, offset: offset) { (recipeHeaderApi , theRecipyType, stateCodeForTheTask) in
                
                // firstthing, let's make sure to negate the id of recipes which belongs to the user
                // we want negitive id# for the user recipies so that they won't mix with the public recipies with core data issiues like favirites & shopping list
                var tempRecipiesApi = recipeHeaderApi
                tempRecipiesApi.rows.removeAll()
                for recipe in recipeHeaderApi.rows {
                    if recipe.user_recipe == true {
                        // negitive id
                        tempRecipiesApi.rows.append(RecipeHeader(id: -recipe.id, title: recipe.title, img: recipe.img, recipe_type: recipe.recipe_type, prep_time: recipe.prep_time, cook_time: recipe.cook_time, serving: recipe.serving, author: recipe.author, ingredient_header1: recipe.ingredient_header1, ingredient_header2: recipe.ingredient_header2, ingredient_header3: recipe.ingredient_header3, list1: recipe.list1, list2: recipe.list2, list3: recipe.list3, directions: recipe.directions))
                    } else {
                        // keep the id
                        tempRecipiesApi.rows.append(RecipeHeader(id: recipe.id, title: recipe.title, img: recipe.img, recipe_type: recipe.recipe_type, prep_time: recipe.prep_time, cook_time: recipe.cook_time, serving: recipe.serving, author: recipe.author, ingredient_header1: recipe.ingredient_header1, ingredient_header2: recipe.ingredient_header2, ingredient_header3: recipe.ingredient_header3, list1: recipe.list1, list2: recipe.list2, list3: recipe.list3, directions: recipe.directions))
                    }
                }
                
                if self.recipes[theRecipyType]! == nil {
                    // there is no data
                    self.recipes[theRecipyType]! = tempRecipiesApi
                } else {
                    // there is already some data, so we need to append
                    self.recipes[theRecipyType]!!.rows.append(contentsOf: tempRecipiesApi.rows)
                }
                
                self.recipHeaderApi = self.recipes[theRecipyType]!
                self.recipiesCollection.reloadData()
                self.recipiesCollection.refreshControl?.endRefreshing()
                self.yet2bePreseedOnce[theRecipyType]! = false
                self.oneTimeActivityIndicator.stopAnimating()
            }
        }
        
        
    }
   
    func refrashData() {
        let recipyTypeString =  getRecipeTypeOfSelectedIndex(number: recipyType.selectedSegmentIndex)
        recipes[recipyTypeString]! = nil
        yet2bePreseedOnce[recipyTypeString]! = true
        retriveData()
    }
    
    func refrashDataOneTimeWheneverANewUserJustSignedIn() {
        for i in 0...7 {
            let recipyTypeString =  getRecipeTypeOfSelectedIndex(number: i)
            recipes[recipyTypeString]! = nil
            yet2bePreseedOnce[recipyTypeString]! = true
        }
        retriveData()
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        appDelegate.defults.set(false, forKey: "haveWeJustFinishLoginProcessSuccefully")
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
    
    func getRecipeTypeOfSelectedIndex(number i: Int) -> String {
        switch i {
        case 0:
            return "Beef"
        case 1:
            print("Pork")
            return "Pork"
        case 2:
            print("Poultry")
            return "Poultry"
        case 3:
            print("Seafood")
            return "Seafood"
        case 4:
            print("Vegetarian")
            return "Vegetarian"
        case 5:
            print("Side_Dish")
            return "Side_Dish"
        case 6:
            print("Salad")
            return "Salad"
        case 7:
            print("Dessert")
            return "Dessert"
        default:
            print("don't know")
            return "Beef"
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

    
    func addTheSideMenuAsSubView(withTheFollowingSignedUser usr: User) {
        let userInfo = Auth.auth().currentUser!.providerData[0]
        var signedUserProfileImageUrl: URL?
        if let userPictureString = userInfo.photoURL?.absoluteString {
            signedUserProfileImageUrl = URL(string: userPictureString + "?type=large")
        } else {
            signedUserProfileImageUrl = URL(string: "No User Profile Picture")
        }
        
        // set the image
        if signedUserProfileImageUrl != nil {
            sideMenuProfileImage.sd_setImage(with: signedUserProfileImageUrl, completed: nil)
        } else {
            // TODO: replace this and setup a generic USER icon insted
            sideMenuProfileImage.sd_setImage(with: signedUserProfileImageUrl, completed: nil)
        }
        
        sideMenuProfileImage.layer.cornerRadius = sideMenuProfileImage.bounds.size.height / 2
        sideMenuProfileImage.clipsToBounds = true
        self.blurView.alpha = 0
        // set the frame around the image
        framForProfileImage.layer.cornerRadius = sideMenuProfileImage.bounds.size.height / 2
        framForProfileImage.clipsToBounds = true
        // set display name & email
        let signedUserEmail = userInfo.email
        displayNameLabel.text = signedUser!.displayName
        emailLabel.text = signedUserEmail
        
        self.view.layoutIfNeeded()
        
    }
    
    func closeTheSideMenu() {
        parentView.isUserInteractionEnabled = true
        parentView.transform = CGAffineTransform.identity
        blurView.alpha = 0
        view.layoutIfNeeded()
    }
    
}
