//
//  ImageLoader.swift
//  HattrickChallenge
//
//  Created by Ivan Grasso on 7/21/21.
//

import Foundation
import UIKit

enum ImageLoadingError: Error {
    case invalidURL
    case invalidData
}

struct ImageLoader {
    
    func loadImage(at urlString: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(.failure(ImageLoadingError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            } else if let data = data,
                      let image = UIImage(data: data) {
                completion(.success(image))
            } else {
                completion(.failure(ImageLoadingError.invalidData))
            }
        }.resume()
    }
}
