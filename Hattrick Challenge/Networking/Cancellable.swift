//
//  Cancellable.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 16/08/2021.
//

import Foundation

protocol Cancellable: AnyObject {
    func cancel()
}

final class DummyCancellable: Cancellable {
    func cancel() { }
}

extension URLSessionDataTask: Cancellable { }
