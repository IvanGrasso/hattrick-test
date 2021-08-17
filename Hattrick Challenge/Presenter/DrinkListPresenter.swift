//
//  DrinkPresenter.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 15/08/2021.
//

import Foundation
import UIKit

protocol DrinkListPresenterView: UIViewController {
    var viewData: DrinkListTableViewController.ViewData? { get set }
}

final class DrinkListPresenter {
    
    weak var view: DrinkListPresenterView?
    
    let service: DrinksService
    
    init(service: DrinksService) {
        self.service = service
    }
    
    func viewDidLoad() {
        service.fetchDrinks(completion: { [weak self] result in
            switch result {
            case .success(let drinks):
                let viewData = DrinkListTableViewController.ViewData(drinks: drinks)
                self?.view?.viewData = viewData
            case .failure(_):
//                FIXME: Handle.
                break
            }
        })
    }
    
    func didSelectDrink(withID id: String) {
        let presenter = DrinkDetailPresenter(drinkID: id, service: service)
        let detailVC = DrinkDetailViewController.make(presenter: presenter)
        presenter.view = detailVC
        view?.navigationController?.pushViewController(detailVC, animated: true)
    }
}
