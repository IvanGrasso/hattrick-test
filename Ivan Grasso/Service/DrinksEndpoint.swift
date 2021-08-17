//
//  DrinksEndpoint.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 16/08/2021.
//

import Foundation

enum DrinksEndpoint {
    case filter
    case lookup(id: String)
}

extension DrinksEndpoint: Endpoint {
    var baseURL: URL {
        URL(string: "https://www.thecocktaildb.com/api/json/v1/1")!
    }
    
    var path: String {
        switch self {
        case .filter: return "filter.php"
        case .lookup: return "lookup.php"
        }
    }
    
    var parameters: [String : String]? {
        switch self {
        case .filter: return ["g": "Cocktail_glass"]
        case .lookup(let id): return ["i": id]
        }
    }
}
