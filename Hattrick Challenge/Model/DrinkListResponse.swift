//
//  DrinkListResponse.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 14/08/2021.
//

import Foundation

struct DrinkListResponse: Decodable {
    let drinks: [DrinkItem]
}
