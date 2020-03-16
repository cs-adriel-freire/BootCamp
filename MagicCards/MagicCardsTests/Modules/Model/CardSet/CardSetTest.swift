//
//  CardSetTest.swift
//  MagicCardsTests
//
//  Created by lucca.f.ferreira on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

@testable import MagicCards
import XCTest
import Foundation

class CardSetTest: XCTestCase {
    
    var sut: CardSet!
    var jsonData: Data!
    
    override func setUp() {
        super.setUp()
        jsonData = """
           {
               "code": "10E",
               "name": "Tenth Edition",
               "type": "core",
               "booster": [
                   "rare",
                   "uncommon",
                   "uncommon",
                   "uncommon",
                   "common",
                   "common",
                   "common",
                   "common",
                   "common",
                   "common",
                   "common",
                   "common",
                   "common",
                   "common",
                   "land",
                   "marketing"
               ],
               "releaseDate": "2007-07-13",
               "block": "Core Set",
               "onlineOnly": false
           }
           """.data(using: .utf8)
        sut = try? CardSet.decoder.decode(CardSet.self, from: jsonData)
        
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testDecodeReleaseDate() {
        let isoDate = "2007-07-13"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from:isoDate)!
        
        XCTAssert(sut.releaseDate == date)
    }

}
