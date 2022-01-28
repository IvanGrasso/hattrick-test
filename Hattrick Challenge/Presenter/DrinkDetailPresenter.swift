//
//  DrinkDetailPresenter.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 16/08/2021.
//

import Foundation

protocol DrinkDetailPresenterView: AnyObject {
    var viewData: DrinkDetailViewController.ViewData? { get set }
}

final class DrinkDetailPresenter {
    
    weak var view: DrinkDetailPresenterView?
    
    let drinkID: String
    
    let service: DrinksService
    
    init(drinkID: String, service: DrinksService) {
        self.drinkID = drinkID
        self.service = service
    }
    
    func viewDidLoad() {
        service.fetchDetail(forID: drinkID, completion: { [weak self] result in
            switch result {
            case .success(let detail):
                DispatchQueue.main.async() {
                    self?.view?.viewData = DrinkDetailViewController.ViewData(detail: detail)
                }
            case .failure(_):
//                FIXME: Handle.
                break
            }
        })
    }
}
