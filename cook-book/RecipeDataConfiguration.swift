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
    var id: Int
    
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

func getRecipeHeaderAPI(typeOfRecipyQuery: String,callback: @escaping (RecipeHeaderAPI, String , Int)-> Void) {
    
    myDataTask?.cancel() // cancel any previus tasks
    
    // This adress will select from the table "recipes_draft1" where the columb "type_of_recipe" is equal to ?  we have to append that value
    let apiAddress = "https://enigmatic-oasis-37206.herokuapp.com/select?table_name=recipes_draft2&col_name=recipe_type&value=\(typeOfRecipyQuery)"
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
