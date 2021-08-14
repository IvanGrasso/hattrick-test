//
//  DrinkPresenter.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 15/08/2021.
//

import Foundation

class DrinkPresenter {
    weak var delegate: DrinkListPresenterDelegate?
    
    let service = DrinksService()
    
    func viewDidLoad() {
        service.fetchDrinks(completion: { [weak self] result in
            switch result {
            case .success(let drinks):
                self?.delegate?.presentDrinks(drinks)
            case .failure(_):
//                FIXME: Handle.
                break
            }
        })
    }
}

typealias DrinkListPresenterDelegate = DrinkPresenterDelegate & DrinkListTableViewController

protocol DrinkPresenterDelegate: AnyObject {
    func presentDrinks(_ drinks: [Drink])
}
