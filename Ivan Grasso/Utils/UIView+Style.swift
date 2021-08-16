//
//  UIView+Style.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 16/08/2021.
//

import Foundation
import UIKit

extension UIView {
    func applyCustomCornersAndShadow() {
        layer.cornerRadius = 6
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 3
    }
}
