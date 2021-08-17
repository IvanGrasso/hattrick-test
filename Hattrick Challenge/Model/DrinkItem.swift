//
//  DrinkItem.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 14/08/2021.
//

import Foundation

struct DrinkItem: Decodable {
    let id: String
    let name: String
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case id = "idDrink"
        case name = "strDrink"
        case thumbnail = "strDrinkThumb"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.thumbnail = try container.decode(String.self, forKey: .thumbnail)
    }
}
