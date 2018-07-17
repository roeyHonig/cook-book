//
//  AppDelegate.swift
//  cook-book
//
//  Created by hackeru on 3 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
// lets bring the favorites

import UIKit
import CoreData
import Firebase
import GoogleSignIn



import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    var defults = UserDefaults.standard // init UserDefults - kind like sheared instance
    
    var sheredRecipyHeader: RecipeHeader? // just a test , delete this
    
    var firstRec: RecipeHeader = RecipeHeader(id: 1)
    var secondRec: RecipeHeader = RecipeHeader(id: 2)

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // init UserDefults - kind like sheared instance
        //let defults = UserDefaults.standard
        firstRec.title = "Delicious Meet"
        firstRec.img = "https://images.media-allrecipes.com/userphotos/560x315/966899.jpg"
        firstRec.ingredient_header1 = "Ingredients"
        firstRec.list1 = ["meet","yams","lemon"]
        firstRec.directions = "cook very slowlly"
        
        secondRec.title = "Delicious Pork"
        secondRec.img = "https://images.media-allrecipes.com/userphotos/560x315/966899.jpg"
        secondRec.ingredient_header1 = "Ingredients"
        secondRec.list1 = ["pork","potatos","cream"]
        secondRec.directions = "cook very fast"
        
        
        
        defults.setValue(true, forKey: "areCoreDataChangesPending")
        
        // init firt FireBase
        FirebaseApp.configure()
        //Google SignIn
        GIDSignIn.sharedInstance().clientID = FirebaseApp.app()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        
        //Facebook
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
        
        return true
    }
    
    
    // Facebook
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application ,open: url,sourceApplication: sourceApplication, annotation: annotation)
    }
    
    
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any])
        -> Bool {
            return GIDSignIn.sharedInstance().handle(url,
                                                     sourceApplication:options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                     annotation: [:])
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
        // Error logging to google
        if let error = error {
            print("failed to log into Google with error: \(error)")
            return
        }
        
        print("Succesfully logged into google: \(user)")
        
        
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                       accessToken: authentication.accessToken)
        
        Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print("failed to log into FireBase with error: \(error)")
                return
            }
            // User is signed in
            // ...
            print("Succesfully logged into FireBase with google: \(user.userID)")
            
        }
        
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        // Perform any operations when the user disconnects from app here.
        // ...
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "cook_book")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    lazy var managedContext = persistentContainer.viewContext
    
    
    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
                
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // saving a recipy and adding it to myFavorites
    func saveThisFavoriteRecipyToCoreData(recipe: RecipeHeader) {
        let entity = NSEntityDescription.entity(forEntityName: "FavoriteRecipes", in: managedContext)!
        let newEntery = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //TODO: cheack if allready exsists
        
        newEntery.setValue(recipe.author, forKey: "author")
        newEntery.setValue(recipe.cook_time, forKey: "cook_time")
        newEntery.setValue(recipe.directions, forKey: "directions")
        newEntery.setValue(recipe.id, forKey: "id")
        newEntery.setValue(recipe.img, forKey: "img")
        newEntery.setValue(recipe.ingredient_header1, forKey: "ingredient_header1")
        newEntery.setValue(recipe.ingredient_header2, forKey: "ingredient_header2")
        newEntery.setValue(recipe.ingredient_header3, forKey: "ingredient_header3")
        newEntery.setValue(recipe.list1, forKey: "list1")
        newEntery.setValue(recipe.list2, forKey: "list2")
        newEntery.setValue(recipe.list3, forKey: "list3")
        newEntery.setValue(recipe.prep_time, forKey: "prep_time")
        newEntery.setValue(recipe.recipe_type, forKey: "recipe_type")
        newEntery.setValue(recipe.serving, forKey: "serving")
        newEntery.setValue(recipe.title, forKey: "title")
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // deleting, we'll delete according to the id of a recipy
    func deletingThisRecipeFromMyFavoritesInCoreData(attribute txt: String, whosValue num: Any?) {
        var myFetchedEntites: [NSManagedObject] = []
        let myPredicate = NSPredicate(format: txt + " = %@", argumentArray: [(num as! Int)])
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteRecipes")
        fetchRequest.predicate = myPredicate
        
        do {
            let fetchedEntities = try managedContext.fetch(fetchRequest)
            myFetchedEntites = fetchedEntities
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        for entity in myFetchedEntites {
            managedContext.delete(entity)
        }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // saving an ingredient list and adding it to my Shopping
    func didSaveToCoreDataWasSuccefull(myRecipeHeader: RecipeHeader) -> Bool {
        var didSaveActionWentOk = false
        var index = 1
        
        let entity = NSEntityDescription.entity(forEntityName: "ShoppingList", in: managedContext)!
        
        if let listOfIngredients1 = myRecipeHeader.list1 {
            for ingrdientInList in listOfIngredients1 {
                let newEntery = NSManagedObject(entity: entity, insertInto: managedContext)
                let title = myRecipeHeader.title ?? ""
                newEntery.setValue(myRecipeHeader.id, forKeyPath: "idOfRecipe")
                newEntery.setValue(title, forKeyPath: "title")
                newEntery.setValue(ingrdientInList, forKeyPath: "ingredient")
                newEntery.setValue(0, forKeyPath: "cheacked")
                newEntery.setValue(0, forKeyPath: "ingredientNumTextLines")
                newEntery.setValue(index, forKeyPath: "index")
                index += 1
                print("This was written")
                print(newEntery)
            }
        }
        
        if let listOfIngredients2 = myRecipeHeader.list2 {
            for ingrdientInList in listOfIngredients2 {
                let newEntery = NSManagedObject(entity: entity, insertInto: managedContext)
                let title = myRecipeHeader.title ?? ""
                newEntery.setValue(myRecipeHeader.id, forKeyPath: "idOfRecipe")
                newEntery.setValue(title, forKeyPath: "title")
                newEntery.setValue(ingrdientInList, forKeyPath: "ingredient")
                newEntery.setValue(0, forKeyPath: "cheacked")
                newEntery.setValue(0, forKeyPath: "ingredientNumTextLines")
                newEntery.setValue(index, forKeyPath: "index")
                index += 1
                print("This was written")
                print(newEntery)
            }
        }
        
        if let listOfIngredients3 = myRecipeHeader.list3 {
            for ingrdientInList in listOfIngredients3 {
                let newEntery = NSManagedObject(entity: entity, insertInto: managedContext)
                let title = myRecipeHeader.title ?? ""
                newEntery.setValue(myRecipeHeader.id, forKeyPath: "idOfRecipe")
                newEntery.setValue(title, forKeyPath: "title")
                newEntery.setValue(ingrdientInList, forKeyPath: "ingredient")
                newEntery.setValue(0, forKeyPath: "cheacked")
                newEntery.setValue(0, forKeyPath: "ingredientNumTextLines")
                newEntery.setValue(index, forKeyPath: "index")
                index += 1
                print("This was written")
                print(newEntery)
            }
        }
        
        do {
            try managedContext.save()
            defults.setValue(true, forKey: "areCoreDataChangesPending")
            didSaveActionWentOk = true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return didSaveActionWentOk
    }
    
    // fetching from coreData all my favorite recipes
    func readCoreDataSavedFavoriteRecipies() -> [RecipeHeader] {
        var ArrayToReturn: [RecipeHeader] = []
        var myManagedObjectToReturn: [NSManagedObject] = []
        // fetch the coreData
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "FavoriteRecipes")
        
         // sort by
         let descriptor1 = NSSortDescriptor(key: "id", ascending: true)
         let descriptors = [descriptor1]
         fetchRequest.sortDescriptors = descriptors
        
        // fetch
        do {
            let favoriesTable = try managedContext.fetch(fetchRequest)
            myManagedObjectToReturn = favoriesTable
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        // iterate, constrct RecipyHeader and append
        for obj in myManagedObjectToReturn {
            let title: String? = obj.value(forKey: "title") as! String?
            let img: String? = obj.value(forKey: "img") as! String?
            let recipe_type: String? = obj.value(forKey: "recipe_type") as! String?
            let prep_time: Int? = obj.value(forKey: "prep_time") as! Int?
            let cook_time: Int? = obj.value(forKey: "cook_time") as! Int?
            let serving: Int? = obj.value(forKey: "serving") as! Int?
            let author: String? = obj.value(forKey: "author") as! String?
            let ingredient_header1: String? = obj.value(forKey: "ingredient_header1") as! String?
            let ingredient_header2: String? = obj.value(forKey: "ingredient_header2") as! String?
            let ingredient_header3: String? = obj.value(forKey: "ingredient_header3") as! String?
            let list1: [String]? = obj.value(forKey: "list1") as! [String]?
            let list2: [String]? = obj.value(forKey: "list2") as! [String]?
            let list3: [String]? = obj.value(forKey: "list3") as! [String]?
            let directions: String? = obj.value(forKey: "directions") as! String?
            let id: Int = obj.value(forKey: "id") as! Int
            
            let tmpRecipe = RecipeHeader(id: id, title: title, img: img, recipe_type: recipe_type, prep_time: prep_time, cook_time: cook_time, serving: serving, author: author, ingredient_header1: ingredient_header1, ingredient_header2: ingredient_header2, ingredient_header3: ingredient_header3, list1: list1, list2: list2, list3: list3, directions: directions)
            ArrayToReturn.append(tmpRecipe)
        }
        
        return ArrayToReturn
    }
    
    // fetching from coreData my complete Sopping List
    func loadCoreData() -> [NSManagedObject] {
        var shoppingListTableToReturn: [NSManagedObject] = []
        // fetch the coreData
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingList")
        let descriptor1 = NSSortDescriptor(key: "idOfRecipe", ascending: true)
        let descriptor2 = NSSortDescriptor(key: "index", ascending: true)
        let descriptors = [descriptor1, descriptor2]
        fetchRequest.sortDescriptors = descriptors
        do {
            let shoppingListTable = try managedContext.fetch(fetchRequest)
            shoppingListTableToReturn = shoppingListTable
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return shoppingListTableToReturn
    }
    
    func cheackForDuplicate(idToCompare: Int) -> Bool {
        var isThereDuplicate = false
        let shoppingListTableToReturn = loadCoreData()
        
        // now that you have all the data, checak if any entity allready has the recipey id?, if yes, that means it was allready added to the shopping list
        for ingredient in shoppingListTableToReturn {
            if let recipeGlobalDBIndex = ingredient.value(forKey: "idOfRecipe") as? Int {
                if recipeGlobalDBIndex == idToCompare {
                    // allready been added to the shoping list, it's true, there's a duplicate
                    isThereDuplicate = true
                }
            }
        }
        return isThereDuplicate
        
    }
    
    func deleteFromCoreDataBasedOn(the attribute: String, whos value: Any?) {
        var myFetchedEntites: [NSManagedObject] = []
        let myPredicate = NSPredicate(format: attribute + " = %@", argumentArray: [(value as! Int)])
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingList")
        fetchRequest.predicate = myPredicate
        
        do {
            let fetchedEntities = try managedContext.fetch(fetchRequest)
            myFetchedEntites = fetchedEntities
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        for entity in myFetchedEntites {
            managedContext.delete(entity)
        }
        
        do {
            try managedContext.save()
            defults.setValue(true, forKey: "areCoreDataChangesPending")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
    // updating Float Values
    func updateDataInCoreDataEntitesMatchedBy(attribute1: String, attribute2: String, value1: Any?, value2: Any? , newValueAttribute: String, newValue: Float) {
        var myFetchedEntites: [NSManagedObject] = []
        let myPredicate = NSPredicate(format: attribute1 + " = %@ AND " + attribute2 + " = %@", argumentArray: [(value1 as! Int), (value2 as! Int)])
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingList")
        fetchRequest.predicate = myPredicate
        
        do {
            let fetchedEntities = try managedContext.fetch(fetchRequest)
            myFetchedEntites = fetchedEntities
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        for entity in myFetchedEntites {
            entity.setValue(newValue, forKey: newValueAttribute)
        }
        
        do {
            try managedContext.save()
            defults.setValue(true, forKey: "areCoreDataChangesPending")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // Updating Int values
    func updateDataInCoreDataEntitesMatchedBy(attribute1: String, attribute2: String, value1: Any?, value2: Any? , newValueAttribute: String, newValue: Int) {
        var myFetchedEntites: [NSManagedObject] = []
        let myPredicate = NSPredicate(format: attribute1 + " = %@ AND " + attribute2 + " = %@", argumentArray: [(value1 as! Int), (value2 as! Int)])
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "ShoppingList")
        fetchRequest.predicate = myPredicate
        
        do {
            let fetchedEntities = try managedContext.fetch(fetchRequest)
            myFetchedEntites = fetchedEntities
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        for entity in myFetchedEntites {
            entity.setValue(newValue, forKey: newValueAttribute)
        }
        
        do {
            try managedContext.save()
            defults.setValue(true, forKey: "areCoreDataChangesPending")
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    

}

