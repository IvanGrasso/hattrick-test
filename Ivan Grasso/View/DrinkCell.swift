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
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var thumbnailImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.text = nil
    }
    
    func updateLayout() {
        guard let viewData = viewData else { return }
        titleLabel.text = viewData.title
        thumbnailImageView.image = nil
        thumbnailImageView.loadImage(fromURLString: viewData.thumbnail)
    }
}

extension DrinkCell.ViewData {
    init(drink: Drink) {
        self.title = drink.strDrink
        self.thumbnail = drink.strDrinkThumb
    }
}
