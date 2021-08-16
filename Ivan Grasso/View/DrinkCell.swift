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
        
        backgroundColor = Colors.mainBackgroundColor
                
        containerView.applyCustomCornersAndShadow()
        thumbnailImageView?.applyCustomCornersAndShadow()
        
        titleLabel.textColor = Colors.Text.mainTextColor
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
    init(drink: DrinkItem) {
        self.title = drink.name
        self.thumbnail = drink.thumbnail
    }
}
