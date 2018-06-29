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
    var type_of_recipe: String?
    var Prep_Time: Int?
    var Cook_Time: Int?
    var Serving: Int?
    var Author: String?
    var Ingredient_Header1: String?
    var Ingredient_Header2: String?
    var Ingredient_Header3: String?
    var id: Int
    
    enum codingKeys: String, CodingKey {
        case title = "title"
        case img = "img"
        case type_of_recipe = "type_of_recipe?"
        case Prep_Time = "Prep_Time"
        case Cook_Time = "Cook_Time"
        case Serving = "Serving"
        case Author = "Author"
        case Ingredient_Header1 = "Ingredient_Header1"
        case Ingredient_Header2 = "Ingredient_Header2"
        case Ingredient_Header3 = "Ingredient_Header3"
        case id = "id"
    }
}


struct RecipeHeaderAPI: Codable {
    var rows: [RecipeHeader]
}

// https://enigmatic-oasis-37206.herokuapp.com/select?table_name=recipes_draft1&col_name=type_of_recipe&value=Pork


let session = URLSession.shared // sheared session for the app
// lets imagin thier's a class with a very big name
// we can give it an alias , a nickname we know
typealias Json = Dictionary<String, Any>

func getRecipeHeaderAPI(typeOfRecipyQuery: String,callback: @escaping (RecipeHeaderAPI)-> Void) {
    // This adress will select from the table "recipes_draft1" where the columb "type_of_recipe" is equal to ?  we have to append that value
    let apiAddress = "https://enigmatic-oasis-37206.herokuapp.com/select?table_name=recipes_draft1&col_name=type_of_recipe&value=\(typeOfRecipyQuery)"
    let apiUrl = URL(string: apiAddress)!
    
    session.dataTask(with: apiUrl) { (data, res, err) in
        guard let data = data else {return}
        // if we got here, we have data
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(RecipeHeaderAPI.self, from: data) else {return /*SHOW DIALOG*/}
        
        // Run code on the UI Thread
        DispatchQueue.main.async {
            callback(result)
        }
        
        
        
        //print(result.rows)
        }.resume()

}
