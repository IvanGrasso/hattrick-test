//
//  DrinkListTableViewController.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 14/08/2021.
//

import UIKit

final class DrinkListTableViewController: UITableViewController {
    
    struct ViewData {
        let drinks: [DrinkItem]
    }
    
    private let presenter: DrinkListPresenter = {
        let service = DrinksService()
        return DrinkListPresenter(service: service)
    }()
    
    private var drinks = [DrinkItem]() {
        didSet {
            DispatchQueue.main.async() {
                self.tableView.reloadData()
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: String(describing: DrinkCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: String(describing: DrinkCell.self))
        
        title = "Cocktail Glass Drinks"
        navigationController?.navigationBar.barTintColor = Colors.mainBackgroundColor
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: Colors.Text.drinkListTitleColor]
        navigationController?.navigationBar.tintColor = Colors.Text.drinkListTitleColor
        
        view.backgroundColor = Colors.mainBackgroundColor
                
        presenter.view = self
        presenter.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drinks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: DrinkCell.self)) as? DrinkCell else {
            return UITableViewCell()
        }
        
        let viewData = DrinkCell.ViewData(drink: drinks[indexPath.row])
        cell.viewData = viewData
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let drinkID = drinks[indexPath.row].id
        presenter.didSelectDrink(withID: drinkID)
    }
}

extension DrinkListTableViewController: DrinkListPresenterView {
    func presentDrinks(_ drinks: [DrinkItem]) {
        self.drinks = drinks
    }
}
