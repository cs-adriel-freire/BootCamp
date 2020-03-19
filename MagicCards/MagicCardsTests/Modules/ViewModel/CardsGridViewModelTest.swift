//
//  CardsGridViewModelTest.swift
//  MagicCardsTests
//
//  Created by c.cruz.agra.lopes on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import XCTest

@testable import MagicCards

final class CardsGridViewModelTest: XCTestCase {

    // MARK: - Variables

    var sut: CardsGridViewModel!
    var abominationCard: Card!
    var abundanceCard: Card!
    var academyCard: Card!

    // MARK: - Methods

    // MARK: Set up

    override func setUp() {
        self.abominationCard = Card(id: "aef2b3de-ed09-591e-ac6b-ecf62bac4a6b",
                                    name: "Abomination of Gudul",
                                    imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=386463&type=card",
                                    types: ["Creature"])
        self.abundanceCard = Card(id: "1669af17-d287-5094-b005-4b143441442f",
                                    name: "Abundance",
                                    imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=130483&type=card",
                                    types: ["Enchantment"])
        self.academyCard = Card(id: "047d5499-a21c-5f5c-9679-1599fcaf9815",
                                name: "Academy Researchers",
                                imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=132072&type=card",
                                types: ["Creature"])

        let referenceDate = Date()
        let cardsBySet: [CardSet: [Card]] = [
            CardSet(id: "KTK", name: "Khans of Tarkir", releaseDate: Date(timeInterval: 10.0, since: referenceDate)):
                [self.abominationCard],
            CardSet(id: "10E", name: "Tenth Edition", releaseDate: Date(timeInterval: 50.0, since: referenceDate)):
                [self.abundanceCard, self.academyCard]
        ]

        self.sut = CardsGridViewModel(cardsBySet: cardsBySet)
    }

    // MARK: Tear down

    override func tearDown() {
        self.abominationCard = nil
        self.abundanceCard = nil
        self.academyCard = nil
        self.sut = nil
    }

    // MARK: Tests

    func testNumberOfSections() {
        XCTAssert(self.sut.numberOfSections == 2)
    }

    func testNumberOsItemsBySection() {
        XCTAssert(self.sut.numberOfItemsBySection[0] == 2)
        XCTAssert(self.sut.numberOfItemsBySection[1] == 1)
    }

    func testHeaderTitleBySection() {
        XCTAssert(self.sut.headerTitleBySection[0] == "Tenth Edition")
        XCTAssert(self.sut.headerTitleBySection[1] == "Khans of Tarkir")
    }

    func testViewModelBySection() {
        XCTAssert(self.sut.viewModelBySection[0][0] == CardCellViewModel(card: self.abundanceCard))
        XCTAssert(self.sut.viewModelBySection[0][1] == CardCellViewModel(card: self.academyCard))
        XCTAssert(self.sut.viewModelBySection[1][0] == CardCellViewModel(card: self.abominationCard))
    }
}
