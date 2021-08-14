//
//  UIImageView+LoadFromURL.swift
//  LuckyChallenge
//
//  Created by Ivan Grasso on 7/21/21.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImage(fromURLString urlString: String?, withContentMode mode: UIView.ContentMode = .scaleAspectFit, placeholder: String? = nil) {
        self.contentMode = mode
        if let placeholder = placeholder {
            self.image = UIImage(named: placeholder)
        }
        if let urlString = urlString,
           let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data) {
                    DispatchQueue.main.async() {
                        self.image = image
                    }
                } else if let error = error {
                    print("Error: Couldn't download image (\(error.localizedDescription))")
                    return
                }
            }.resume()
        }
    }
}
