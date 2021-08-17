//
//  Endpoint.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 16/08/2021.
//

import Foundation

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var parameters: [String: String]? { get }
}
