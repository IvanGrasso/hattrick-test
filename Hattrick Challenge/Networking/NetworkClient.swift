//
//  NetworkClient.swift
//  Ivan Grasso
//
//  Created by Ivan Grasso on 16/08/2021.
//

import Foundation

extension NetworkClient {
    enum Error: Swift.Error {
        case couldNotBuildURLComponents(partialURL: URL)
        case couldNotBuildURL(partialURL: URL, parameters: [String: String]?)
    }
}

final class NetworkClient<E: Endpoint> {
    
    let urlSession:  URLSession
    
    init(urlSession: URLSession = .shared) {
        self.urlSession = urlSession
    }
    
    @discardableResult
        public func execute<T: Decodable>(_ endpoint: E, completion: ((Result<T, Swift.Error>) -> Void)?) -> Cancellable {
            do {
                let url = try makeURL(for: endpoint)
                let task = urlSession.dataTask(with: url) { data, response, error in
                    switch (data, response, error) {
                    case (.some(let data), let urlResponse as HTTPURLResponse, _) where (200...299).contains(urlResponse.statusCode):
                        do {
                            let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                            completion?(.success(decodedResponse))
                        } catch {
                            completion?(.failure(error))
                        }
                    case (_, _, .some(let error)):
                        completion?(.failure(error))
                    default: break
                    }
                }
                
                task.resume()
                return task
            } catch {
                return DummyCancellable()
            }
        }
        
        private func makeURL(for endpoint: E) throws -> URL {
            let partialURL = endpoint.baseURL.appendingPathComponent(endpoint.path)
            guard var components = URLComponents(url: partialURL, resolvingAgainstBaseURL: false) else {
                throw Error.couldNotBuildURLComponents(partialURL: partialURL)
            }
            
            if let parameters = endpoint.parameters {
                var queryItems = [URLQueryItem]()
                parameters.forEach { queryItems.append(URLQueryItem(name: $0.key, value: $0.value)) }
                components.queryItems = queryItems
            }
            
            guard let url = components.url else {
                throw Error.couldNotBuildURL(partialURL: partialURL, parameters: endpoint.parameters)
            }
            
            return url
        }
}
