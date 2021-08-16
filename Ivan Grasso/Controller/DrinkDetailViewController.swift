//
//  DrinkDetailViewController.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 16/08/2021.
//

import Foundation
import UIKit

class DrinkDetailViewController: UIViewController {
    
    struct ViewData {
        let title: String
        let imageURL: String
        let ingredients: [String]
        let instructions: String
    }
    
    var viewData: ViewData? {
        didSet {
            updateLayout()
        }
    }
    
    @IBOutlet weak private var containerView: UIView!
    @IBOutlet weak private var contentStackView: UIStackView!
    @IBOutlet weak private var imageView: UIImageView!
    private let instructionsTitleLabel = UILabel()
    private let instructionsLabel = UILabel()
    
    static func make() -> DrinkDetailViewController {
        return DrinkDetailViewController(nibName: String(describing: DrinkDetailViewController.self), bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Colors.mainBackgroundColor
        containerView.applyCustomCornersAndShadow()
        contentStackView.spacing = 16
        
        instructionsTitleLabel.textColor = Colors.Text.mainTextColor
        
        instructionsLabel.textColor = Colors.Text.mainTextColor
        instructionsLabel.numberOfLines = 0
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let viewData = viewData else { return }
        title = viewData.title
    }
    
    private func updateLayout() {
        guard let viewData = viewData,
              self.isViewLoaded else { return }
                
        imageView.loadImage(fromURLString: viewData.imageURL, withContentMode: .scaleAspectFill)
        
        contentStackView.arrangedSubviews.forEach{ $0.removeFromSuperview() }
        
        let ingredientsStackView = UIStackView()
        ingredientsStackView.axis = .vertical
        viewData.ingredients.forEach { ingredient in
            let label = UILabel()
            label.textColor = Colors.Text.mainTextColor
            label.text = ingredient
            ingredientsStackView.addArrangedSubview(label)
        }
        contentStackView.addArrangedSubview(ingredientsStackView)
        
        instructionsTitleLabel.text = "• How to prepare"
        contentStackView.addArrangedSubview(instructionsTitleLabel)
        
        instructionsLabel.text = viewData.instructions
        contentStackView.addArrangedSubview(instructionsLabel)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateLayout()
    }
}

extension DrinkDetailViewController.ViewData {
    init(detail: DrinkDetail) {
        self.title = detail.name
        self.imageURL = detail.thumbnail
        self.ingredients = detail.measures.enumerated().map { index, measure in
            guard detail.ingredients.indices.contains(index) else { return "" }
            return measure + " - \(detail.ingredients[index])"
        }
        self.instructions = detail.instructions
    }
}
