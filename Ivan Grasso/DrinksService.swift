//
//  DrinkService.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 14/08/2021.
//

import Foundation

class DrinksService {
    let url = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/filter.php?g=Cocktail_glass")!
    
    func fetchDrinks(completion: @escaping (Result<[Drink], Error>) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data,
                      let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 {
                do {
                    let response = try JSONDecoder().decode(DrinkResponse.self, from: data)
                    completion(.success(response.drinks))
                } catch {
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}
