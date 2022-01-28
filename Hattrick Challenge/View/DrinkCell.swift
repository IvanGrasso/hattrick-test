//
//  DrinkCell.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 14/08/2021.
//

import Foundation
import UIKit

final class DrinkCell: UITableViewCell {
    
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
        thumbnailImageView.image = UIImage(named: "cocktail-placeholder")
        
        ImageLoader().loadImage(at: viewData.thumbnail) { [weak self] result in
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.thumbnailImageView.image = image
                }
            case .failure(_):
//                TODO: Handle.
                break
            }
        }
    }
}

extension DrinkCell.ViewData {
    init(drink: DrinkItem) {
        self.title = drink.name
        self.thumbnail = drink.thumbnail
    }
}
