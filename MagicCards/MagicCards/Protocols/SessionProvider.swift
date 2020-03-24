//
//  SessionProvider.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol SessionProvider {
    
    var urlSession: URLSession { get set }
    var requestBuilders: [String: SessionRequestBuilder] { get set }
    var decoder: JSONDecoder { get set }
    
    init(urlSession: URLSession, requestBuilders: [String: SessionRequestBuilder], decoder: JSONDecoder)
    
    func fetch<I: Codable>(withRequest request: URLRequest,
                           decoder: JSONDecoder,
                           completion: @escaping (Result<(I, URLResponse), SessionProviderError>) -> Void)
    
}

extension SessionProvider {
    
    func fetch<I>(withRequest request: URLRequest,
                  decoder: JSONDecoder,
                  completion: @escaping (Result<(I, URLResponse), SessionProviderError>) -> Void) where I: Decodable, I: Encodable {
        let task = urlSession.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(.unknownResponse))
                return
            }
            guard let data = data else {
                completion(.failure(.withoutData))
                return
            }
            switch response.statusCode {
            case 400...499:
                completion(.failure(.requestError(response.statusCode)))
                return
            case 500...599:
                completion(.failure(.serverError(response.statusCode)))
                return
            default:
                break
            }
            guard let dto = try? decoder.decode(I.self, from: data) else {
                completion(.failure(.decodeError))
                return
            }
            completion(.success((dto, response)))
            return
        }
        task.resume()
    }

}

enum SessionProviderError: Error {
    case unknownResponse
    case networkError(Error)
    case requestError(Int)
    case requestBuilderError
    case serverError(Int)
    case unhandledResponse
    case decodeError
    case withoutData
}
