//
//  MagicAPIProviderTest.swift
//  MagicCardsTests
//
//  Created by lucca.f.ferreira on 19/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

@testable import MagicCards

import XCTest

final class MagicAPIProviderTest: XCTestCase {

    var sut: MagicAPIProvider!
    var urlSessionStub: URLSessionStub!
    var requestBuilders: [String: SessionRequestBuilder]!
    var decoder: JSONDecoder!
    var urlRequest: URLRequest!
    
    override func setUp() {
        urlSessionStub = URLSessionStub()
        requestBuilders = [:]
        decoder = JSONDecoder()
        urlRequest = URLRequest(url: URL(string: "www.google.com")!)
        sut = MagicAPIProvider(urlSession: urlSessionStub, requestBuilders: requestBuilders, decoder: decoder)
    }

    override func tearDown() {
        urlSessionStub = nil
        requestBuilders = nil
        decoder = nil
        urlRequest = nil
        sut = nil
    }
    
    func testRequestWithoutConnection() {
        urlSessionStub.shouldReturnError = true
        sut.fetchCardSets { (result) in
            switch result {
            case .success:
                XCTFail("Expect .failure completion return")
            case .failure:
                XCTAssert(true)
            }
        }
    }
    
    func testRequestWithUnknownResponse() {
        urlSessionStub.urlResponse = nil
        sut.fetchCardSets { (result) in
            switch result {
            case .success:
                XCTFail("Expect .failure completion return")
            case .failure:
                XCTAssert(true)
            }
        }
    }
    
    func testRequestWithoutData() {
        urlSessionStub.dataResponse = nil
        sut.fetchCardSets { (result) in
            switch result {
            case .success:
                XCTFail("Expect .failure completion return")
            case .failure:
                XCTAssert(true)
            }
        }
    }
    
    func testRequestWithWrongStatusCode() {
        urlSessionStub.statusCode = 450
        sut.fetchCardSets { (result) in
            switch result {
            case .success:
                XCTFail("Expect .failure completion return")
            case .failure:
                XCTAssert(true)
            }
        }
    }
    
    func testFetchCardSets() {
        // swiftlint:disable line_length
        urlSessionStub.dataResponse =  """
                   {"cards":[{"name":"Abundance","types":["Enchantment"],"set":"10E","setName":"Tenth Edition","imageUrl":"http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=130483&type=card","id":"1669af17-d287-5094-b005-4b143441442f"}]}
                   """.data(using: .utf8)
        // swiftlint:enable line_length
        
        sut.fetchCards(withSet: "") { (result) in
            switch result {
            case .success(let cards):
                XCTAssert(cards.count == 1)
                XCTAssert(cards[0].id == "1669af17-d287-5094-b005-4b143441442f")
                XCTAssert(cards[0].name == "Abundance")
                XCTAssert(cards[0].types == ["Enchantment"])
                XCTAssert(cards[0].imageUrl == "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=130483&type=card")
            case .failure:
                XCTFail("Expect one card in the request response")
            }
        }
    }
    
}
