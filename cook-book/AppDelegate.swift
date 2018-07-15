//
//  AppDelegate.swift
//  cook-book
//
//  Created by hackeru on 3 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
// lets bring the shopping list again, it seems we did it, now let's delete, we're getting there

import UIKit
import CoreData
import Firebase
import GoogleSignIn



import FBSDKCoreKit
import FBSDKLoginKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // init UserDefults - kind like sheared instance
        let defults = UserDefaults.standard
        
        
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
            didSaveActionWentOk = true
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
        return didSaveActionWentOk
    }
    
    
    
    
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
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
        
    }
    
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
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    

}

