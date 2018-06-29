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
