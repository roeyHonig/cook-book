//
//  RecipeDataConfiguration.swift
//  cook-book
//
//  Created by hackeru on 16 Tamuz 5778.
//  Copyright © 5778 student.roey.honig. All rights reserved.
//

import Foundation

struct RecipeHeader: Codable {
    var title: String?
    var img: String?
    var recipe_type: String?
    var prep_time: Int?
    var cook_time: Int?
    var serving: Int?
    var author: String?
    var ingredient_header1: String?
    var ingredient_header2: String?
    var ingredient_header3: String?
    var list1: [String]?
    var list2: [String]?
    var list3: [String]?
    var directions: String?
    var user_recipe: Bool?
    var id: Int
    
    init(id x: Int) {
        self.id = x
    }
    
    init(id x: Int, title t: String?, img i: String?, recipe_type rt: String?, prep_time prept: Int?, cook_time cookt: Int? ,serving serv: Int?, author aut: String?, ingredient_header1 ih1: String?, ingredient_header2 ih2: String?, ingredient_header3 ih3: String?,
          list1 lis1: [String]?, list2 lis2: [String]?, list3 lis3: [String]?, directions dir: String?) {
        self.id = x
        self.title = t
        self.img = i
        self.recipe_type = rt
        self.prep_time = prept
        self.cook_time = cookt
        self.serving = serv
        self.author = aut
        self.ingredient_header1 = ih1
        self.ingredient_header2 = ih2
        self.ingredient_header3 = ih3
        self.list1 = lis1
        self.list2 = lis2
        self.list3 = lis3
        self.directions = dir
        
    }
    
    enum codingKeys: String, CodingKey {
        case title = "title"
        case img = "img"
        case recipe_type = "recipe_type"
        case prep_time = "prep_time"
        case cook_time = "cook_time"
        case serving = "serving"
        case author = "author"
        case ingredient_header1 = "ingredient_header1"
        case ingredient_header2 = "ingredient_header2"
        case ingredient_header3 = "ingredient_header3"
        case list1 = "list1"
        case list2 = "list2"
        case list3 = "list3"
        case directions = "directions"
        case user_recipe = "user_recipe"
        case id = "id"
    }
}


struct RecipeHeaderAPI: Codable {
    var rows: [RecipeHeader]
}


// https://enigmatic-oasis-37206.herokuapp.com/select?table_name=recipes_draft1&col_name=type_of_recipe&value=Pork


let session = URLSession.shared // sheared session for the app
var myDataTask: URLSessionDataTask?

// https://www.raywenderlich.com/158106/urlsession-tutorial-getting-started

// lets imagin thier's a class with a very big name
// we can give it an alias , a nickname we know
typealias Json = Dictionary<String, Any>

func getRecipeHeaderAPI(nameOfDBTable: String ,nameOfAutor: String? ,typeOfRecipyQuery: String , limit: Int, offset: Int,callback: @escaping (RecipeHeaderAPI, String , Int)-> Void) {
    
    myDataTask?.cancel() // cancel any previus tasks
    
    // choose between 2 diffrent API web adress, 1 for public recipes (there is no autor) & 1 for a specific user
    var apiAddress: String
    if nameOfAutor != nil {
        // user based recipes
        // https://enigmatic-oasis-37206.herokuapp.com/selectBasedAutor?table_name=recipes_of_users&col_name=recipe_type&value=Beef&autor=talefroni94@gmail.com&limit=3&offset=0
        apiAddress = "https://enigmatic-oasis-37206.herokuapp.com/selectBasedAutor?table_name=\(nameOfDBTable)&col_name=recipe_type&value=\(typeOfRecipyQuery)&autor=\(nameOfAutor!)&limit=\(limit)&offset=\(offset)"
    } else {
        // public
        // This adress will select from the table "recipes_draft2" where the columb "recipe_type" is equal to ?  we have to append that value
        // also we have to append the limit and offset values
        //https://enigmatic-oasis-37206.herokuapp.com/select?table_name=recipes_draft2&col_name=recipe_type&value=Pork&limit=3&offset=0
        apiAddress = "https://enigmatic-oasis-37206.herokuapp.com/select?table_name=\(nameOfDBTable)&col_name=recipe_type&value=\(typeOfRecipyQuery)&limit=\(limit)&offset=\(offset)"
    }
  
    let apiUrl = URL(string: apiAddress)!
    
    myDataTask = session.dataTask(with: apiUrl) { (data, res, err) in
        guard let data = data else {return}
        // if we got here, we have data
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(RecipeHeaderAPI.self, from: data) else {return /*SHOW DIALOG*/}
        
        
        // Run code on the UI Thread
        
        DispatchQueue.main.async {
            callback(result , typeOfRecipyQuery , myDataTask!.state.rawValue)
        }
        
        
        
        //print(result.rows)
    }
    
    myDataTask?.resume()
   
}





// Be Advided!!
// URL class needs a clean string for the init, what does that mean?
// it means the following chracters are probited: " " white space replace with _   , " double qoutation mark replace with $  , {   curelly braces replace with [
func writeRecipeHeaderIntoSQLTableAPI(myRecipe: RecipeHeader ,callback: @escaping (Error?)-> Void) {
    
    myDataTask?.cancel() // cancel any previus tasks
    
    // choose between 2 diffrent API web adress, 1 for public recipes (there is no autor) & 1 for a specific user
    var apiAddress: String
    
        // user based recipes
        // https://enigmatic-oasis-37206.herokuapp.com/insertRecipe?title='very delicios3'&img='img.url'&recipeType='Pork'&prepTime=20&cookTime=10&serving=5&author='roeyhonig100@walla.com'&ingredientHeader1='ingredients for cake'&ingredientHeader2='ingredients for icing on the cake'&ingredientHeader3='ingredients for topincs on the cake'&list1='{"parcelly","lemon and lymes", "donats"}'&list2='{"parcelly","lemon and lymes, with jelly beans", "donats"}'&list3='{"parcelly","lemon and lymes, with jelly beans", "donats"}'&directions='Place meat in slow cooker. In a small bowl mix together the flour, salt, and pepper; pour over meat, and stir'
    
    var title = "'very'"
    var img = "'img'"
    var recipeType = "'Beef'"
    var prepTime = 39
    var cookTime = 2
    var serving = 3
    var author = "'roeyhonig92@walla.com'"
    var ingredientHeader1 = "'for_cake,_and[]'"
    var ingredientHeader2 = "'for_icing'"
    var ingredientHeader3 = "'topics'"
    var list1 = preperForSql(fromTheFollwingStringArray: ["lemon_yes", "lyme_no","a_lot_of_love"])
    var list2 = "null"
    var list3 = "null"
    var directions = "null"

    
    
    apiAddress = "https://enigmatic-oasis-37206.herokuapp.com/insertRecipe?title="
    apiAddress = apiAddress + title
    apiAddress = apiAddress + "&img=" + img
    apiAddress = apiAddress + "&recipeType=" + recipeType
    apiAddress = apiAddress + "&prepTime=" + "\(prepTime)"
    apiAddress = apiAddress + "&cookTime=" + "\(cookTime)"
    apiAddress = apiAddress + "&serving=" + "\(serving)"
    apiAddress = apiAddress + "&author=" + author
    apiAddress = apiAddress + "&ingredientHeader1="+ingredientHeader1
    apiAddress = apiAddress + "&ingredientHeader2="+ingredientHeader2
    apiAddress = apiAddress + "&ingredientHeader3="+ingredientHeader3
    apiAddress = apiAddress + "&list1="+list1
    apiAddress = apiAddress + "&list2="+list2
    apiAddress = apiAddress + "&list3="+list3
    apiAddress = apiAddress + "&directions="+directions
    
   
    //let components = NSURL(string: apiAddress)
    
    print(apiAddress)
    let apiUrl = URL(string: apiAddress)!
    //let apiUrl = components!.absoluteURL!
    
    myDataTask = session.dataTask(with: apiUrl) { (data, res, err) in
        guard let data = data else {return}
        // if we got here, we have data
        //let decoder = JSONDecoder()
       // guard let result = try? decoder.decode(RecipeHeaderAPI.self, from: data) else {return /*SHOW DIALOG*/}
        
        
        // Run code on the UI Thread
        
        DispatchQueue.main.async {
            callback(err)
        }
        
        
        
        //print(result.rows)
    }
    
    myDataTask?.resume()
    
}





func surrondWithDoubleQutationMark(theFollowingString s: String) -> String {
    let s1 = """
    $\(s)$
    """
    return s1
}

// will transfer ["parcelly, in salt", "lymes, cut in half", "some, good stuff"] --> '[$parcelly, in salt$,$lymes, cut in half$,$some, good stuff$]'
// this is how we need to enter it via the fet request so the sql query will function properlly
func preperForSql(fromTheFollwingStringArray arr: [String]) -> String {
    var stringToReturn = ""
    stringToReturn = stringToReturn + "'["
    
    for i in 1...arr.count {
        if i == arr.count {
            stringToReturn = stringToReturn + surrondWithDoubleQutationMark(theFollowingString: arr[i-1])
        } else {
            stringToReturn = stringToReturn + surrondWithDoubleQutationMark(theFollowingString: arr[i-1]) + ","
        }
    }
    
    stringToReturn = stringToReturn + "]'"
    return stringToReturn
}
