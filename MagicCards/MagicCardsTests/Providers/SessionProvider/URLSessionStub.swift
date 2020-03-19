//
//  URLSessionStub.swift
//  MagicCardsTests
//
//  Created by lucca.f.ferreira on 19/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

final class URLSessionStub: URLSession {
    
    // MARK: - Variables

    var shouldReturnError: Bool = false
    var dataResponse: Data? = Data()
    var urlResponse: HTTPURLResponse? = HTTPURLResponse()
    var statusCode: Int = 200
    var error: Error = NSError(domain: String(), code: 404, userInfo: nil)
    
    // MARK: - Methods

    override func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        if !shouldReturnError {
            urlResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)!
            completionHandler(dataResponse, urlResponse , nil)
            return URLSessionDataTaskFake()
        }
        completionHandler(nil, nil , error)
        return URLSessionDataTaskFake()
    }

}

final class URLSessionDataTaskFake: URLSessionDataTask {
    override func resume() { }
}
