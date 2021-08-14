//
//  DrinkListTableViewController.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 14/08/2021.
//

import UIKit

class DrinkListTableViewController: UITableViewController {
    
    private let presenter = DrinkPresenter()
    private var drinks = [Drink]() {
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
        
        presenter.delegate = self
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
    }
}

extension DrinkListTableViewController: DrinkPresenterDelegate {
    func presentDrinks(_ drinks: [Drink]) {
        self.drinks = drinks
    }
}
