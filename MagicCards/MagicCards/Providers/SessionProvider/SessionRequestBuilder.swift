//
//  SessionRequestBuilder.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

struct SessionRequestBuilder {
    
    enum Method: String {
        case get
        case post
        case put
        case delete
    }
    
    private let baseURL: URL
    private let path: String
    private let method: Method
    private let headers: [String: String]
    
    init(baseURL: URL, path: String, method: Method = .get, headers: [String: String] = [:]) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
    }
    
    func request(withParams params: [URLQueryItem] = []) -> URLRequest {
        var components = URLComponents(url: baseURL.appendingPathComponent(path), resolvingAgainstBaseURL: false)!
        components.queryItems = params
        let url = components.url!
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        request.httpMethod = method.rawValue.uppercased()
        return request
    }
    
}
