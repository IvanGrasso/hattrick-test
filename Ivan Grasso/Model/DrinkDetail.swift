//
//  DrinkDetail.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 16/08/2021.
//

import Foundation

struct DrinkDetail: Decodable {
    let name: String
    let instructions: String
    let thumbnail: String
    let ingredients: [String]
    
    enum CodingKeys: String, CodingKey {
        case name = "strDrink"
        case instructions = "strInstructions"
        case thumbnail = "strDrinkThumb"
    }
    
    struct DynamicKey: CodingKey {
        var intValue: Int?
        
        init?(intValue: Int) {
            return nil
        }
        
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try container.decode(String.self, forKey: .name)
        self.instructions = try container.decode(String.self, forKey: .instructions)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
        
        let dynamicKeysContainer = try decoder.container(keyedBy: DynamicKey.self)
        
        self.ingredients = dynamicKeysContainer.allKeys.filter{ $0.stringValue.contains("strIngredient") }.compactMap{
            try? dynamicKeysContainer.decode(String.self, forKey: $0)
        }
    }
    
}
