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
func writeRecipeHeaderIntoSQLTableAPI(myRecipe: RecipeHeader, newAuthor: String ,callback: @escaping (Error?)-> Void) {
    
    myDataTask?.cancel() // cancel any previus tasks
    
    // choose between 2 diffrent API web adress, 1 for public recipes (there is no autor) & 1 for a specific user
    var apiAddress: String
    
        // user based recipes
        // https://enigmatic-oasis-37206.herokuapp.com/insertRecipe?title='very delicios3'&img='img.url'&recipeType='Pork'&prepTime=20&cookTime=10&serving=5&author='roeyhonig100@walla.com'&ingredientHeader1='ingredients for cake'&ingredientHeader2='ingredients for icing on the cake'&ingredientHeader3='ingredients for topincs on the cake'&list1='{"parcelly","lemon and lymes", "donats"}'&list2='{"parcelly","lemon and lymes, with jelly beans", "donats"}'&list3='{"parcelly","lemon and lymes, with jelly beans", "donats"}'&directions='Place meat in slow cooker. In a small bowl mix together the flour, salt, and pepper; pour over meat, and stir'
    let newTitle : String
    if let originTitle = myRecipe.title {
        newTitle = "My " + originTitle
    } else {
        newTitle = "My"
    }
    
    var title = preperForSql(TheFollwingString: newTitle)
    var img = preperForSql(TheFollwingString: myRecipe.img)
    var recipeType = preperForSql(TheFollwingString: myRecipe.recipe_type)
    var prepTime = preperForSql(TheFollwingInt: myRecipe.prep_time)
    var cookTime = preperForSql(TheFollwingInt: myRecipe.cook_time)
    var serving = preperForSql(TheFollwingInt: myRecipe.serving)
    var author = preperForSql(TheFollwingString: newAuthor)
    var ingredientHeader1 = preperForSql(TheFollwingString: myRecipe.ingredient_header1)
    var ingredientHeader2 = preperForSql(TheFollwingString: myRecipe.ingredient_header2)
    var ingredientHeader3 = preperForSql(TheFollwingString: myRecipe.ingredient_header3)
    var list1 = preperForSql(TheFollwingStringArray: myRecipe.list1)
    var list2 = preperForSql(TheFollwingStringArray: myRecipe.list2)
    var list3 = preperForSql(TheFollwingStringArray: myRecipe.list3)
    var directions = preperForSql(TheFollwingString: myRecipe.directions)

    
    // TODO: change the api to the new                      insertRecipeStrings   // insertRecipeStrings
    apiAddress = "https://enigmatic-oasis-37206.herokuapp.com/insertRecipeStrings?title="
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
    // TODO: !!!! very important you must guard of nil values due to invalid adress
    let nonOptionalApiUrl: URL
    if let apiUrl = URL(string: apiAddress)  {
        nonOptionalApiUrl = apiUrl
    } else {
        nonOptionalApiUrl = URL(string: "url_is_invalid")!
    }
    
    //let apiUrl = URL(string: "https://enigmatic-oasis-37206.herokuapp.com/insertRecipe?title='Awesome_Red_Wine_Pot_Roast'&img='https://images.media-allrecipes.com/userphotos/560x315/597886.jpg'&recipeType='Beef'&prepTime=15&cookTime=240&serving=12&author='https://www.allrecipes.com/recipe/162091/awesome-red-wine-pot-roast/'&ingredientHeader1='_Ingredients_'&ingredientHeader2=null&ingredientHeader3=null&list1='[3_pounds_boneless_beef_chuck_roast,2_tablespoons_all-purpose_flour,2_tablespoons_canola_oil,1/2_cup_water_,1/2_cup_red_wine_,1_teaspoon_dried_basil_,1/2_teaspoon_dried_marjoram_,1/2_teaspoon_dried_thyme_,1_teaspoon_salt_,1/4_teaspoon_ground_black_pepper_,1_onion,_sliced_,6_red_potatoes,_washed_and_halved_,6_carrot,_peeled_and_cut_into_2-inch_lengths_,8_pearl_onions,_peeled_and_halved_]'&list2=null&list3=null&directions='Preheat_an_oven_to_350_degrees_F_(175_degrees_C).#Sprinkle_the_roast_evenly_with_the_flour_and_set_aside._Heat_the_canola_oil_in_an_oven-proof_Dutch_oven_with_lid_over_medium-high_heat._Brown_the_roast_on_all_sides,_about_10_minutes_total_remove_from_the_heat._Pour_in_the_water_and_wine._Sprinkle_with_the_basil,_marjoram,_thyme,_salt,_and_pepper._Arrange_the_onion_slices_on_the_roast.#Replace_the_cover_and_bake_in_the_preheated_oven_for_3_hours._Add_the_potatoes,_carrots,_and_pearl_onions._Pour_in_additional_water_if_the_roast_looks_dry._Continue_baking_covered_until_the_roast_pulls_apart_easily_with_a_fork,_about_1_hour_longer.#'")!
    
    myDataTask = session.dataTask(with: nonOptionalApiUrl) { (data, res, err) in
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

func elimanateLineBreakes(fromTheFollowingString str: String) -> String {
    let components = str.components(separatedBy: "\n")
    return components.joined(separator: "newLine")
}

func elimanateWhiteSpaces(fromTheFollowingString aString: String) -> String {
    let newString = aString.replacingOccurrences(of: " ", with: "_")
    return newString
}



func surrondWithDollarSignMarkMark(theFollowingString s: String) -> String {
    let s1 = """
    singleQutation\(s)singleQutation
    """
    return s1
}

// will transfer ["parcelly, in salt", "lymes, cut in half", "some, good stuff"] --> '[$parcelly, in salt$,$lymes, cut in half$,$some, good stuff$]'
// this is how we need to enter it via the fet request so the sql query will function properlly
func preperForSql(TheFollwingStringArray myArr: [String]?) -> String {
    guard let arr = myArr else {
        return "null"
    }
    
    var stringToReturn = ""
    stringToReturn = stringToReturn + "'["
    
    for i in 1...arr.count {
        if i == arr.count {
            stringToReturn = stringToReturn + surrondWithDollarSignMarkMark(theFollowingString: elimanateWhiteSpaces(fromTheFollowingString: elimanateLineBreakes(fromTheFollowingString: arr[i-1])))
        } else {
            stringToReturn = stringToReturn + surrondWithDollarSignMarkMark(theFollowingString: elimanateWhiteSpaces(fromTheFollowingString: elimanateLineBreakes(fromTheFollowingString: arr[i-1])))  + ","
        }
    }
    
    stringToReturn = stringToReturn + "]'"
    return stringToReturn
}

func preperForSql(TheFollwingInt str: Int?) -> String {
    guard let str1 = str else {
        return "null"
    }

    let stringToReturn = "\(str1)"
    return stringToReturn
}

func preperForSql(TheFollwingString str: String?) -> String {
    guard let str1 = str else {
    return "null"
    }

    let stringToReturn = "'" + elimanateWhiteSpaces(fromTheFollowingString: elimanateLineBreakes(fromTheFollowingString: str1)) + "'"
    return stringToReturn
}

