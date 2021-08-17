//
//  DrinkService.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 14/08/2021.
//

import Foundation

extension DrinksService {
    enum Error: Swift.Error {
        case noDrinkFound
    }
}

final class DrinksService {
    
    let client: NetworkClient<DrinksEndpoint>
    
    init(client: NetworkClient<DrinksEndpoint> = .init()) {
        self.client = client
    }
    
    func fetchDrinks(completion: @escaping (Result<[DrinkItem], Swift.Error>) -> Void) {
        client.execute(.filter) { (result: Result<DrinkListResponse, Swift.Error>) in
            switch result {
            case .success(let response): completion(.success(response.drinks))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
    
    func fetchDetail(forID id: String, completion: @escaping (Result<DrinkDetail, Swift.Error>) -> Void) {
        client.execute(.lookup(id: id)) { (result: Result<DrinkDetailResponse, Swift.Error>) in
            switch result {
            case .success(let response):
                guard let drink = response.drinks.first else {
                    completion(.failure(DrinksService.Error.noDrinkFound))
                    return
                }
                completion(.success(drink))
            case .failure(let error): completion(.failure(error))
            }
        }
    }
}
