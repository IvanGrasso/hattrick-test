//
//  DrinkCell.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 14/08/2021.
//

import Foundation
import UIKit

class DrinkCell: UITableViewCell {
    
    struct ViewData {
        let title: String
        let thumbnail: String
    }
    
    var viewData: ViewData? {
        didSet {
            updateLayout()
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor(red: 0.30, green: 0.74, blue: 0.82, alpha: 1)
                
        containerView.layer.cornerRadius = 6
        containerView.applyCustomShadow()
        
        thumbnailImageView?.layer.cornerRadius = 6
        thumbnailImageView?.applyCustomShadow()
        
        titleLabel.textColor = Colors.Text.drinkTitleColor
        titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .regular)
        titleLabel.text = nil
    }
    
    func updateLayout() {
        guard let viewData = viewData else { return }
        
        titleLabel.text = viewData.title
        thumbnailImageView.image = nil
        thumbnailImageView.loadImage(fromURLString: viewData.thumbnail, placeholder: "cocktail-placeholder")
    }
}

extension DrinkCell.ViewData {
    init(drink: Drink) {
        self.title = drink.strDrink
        self.thumbnail = drink.strDrinkThumb
    }
}

private extension UIView {
    func applyCustomShadow() {
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
    }
}
