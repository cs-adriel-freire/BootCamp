//
//  CardsGridViewTest.swift
//  MagicCardsSnapshotTests
//
//  Created by c.cruz.agra.lopes on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//
import UIKit
import Nimble
import Nimble_Snapshots
import XCTest

@testable import MagicCards

final class CardsGridViewTest: XCTestCase {

    // MARK: - Variables

    // MARK: SUT

    var sut: CardsGridView!

    // MARK: Helpers

    var viewModel: CardsGridViewModel!
    var referenceDate: Date!
    var cardsBySet: [CardSet: [Card]]!

    // MARK: - Methods

    // MARK: Set up

    override func setUp() {
        self.cardsBySet = [:]
        self.referenceDate = Date()
        self.setupInitialViewModel()
        self.sut = CardsGridView(frame: UIScreen.main.bounds, viewModel: self.viewModel)
    }

    private func setupInitialViewModel() {
        let abundanceCard = Card(id: "1669af17-d287-5094-b005-4b143441442f",
                                    name: "Abundance",
                                    imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=130483&type=card",
                                    types: ["Enchantment"])
        abundanceCard.imageData = UIImage(named: "cardForTest")?.pngData()

        let academyCard = Card(id: "047d5499-a21c-5f5c-9679-1599fcaf9815",
                                name: "Academy Researchers",
                                imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=132072&type=card",
                                types: ["Creature"])
        academyCard.imageData = UIImage(named: "cardForTest")?.pngData()

        self.cardsBySet[CardSet(id: "10E",
                                name: "Tenth Edition",
                                releaseDate: Date(timeInterval: 50.0, since: self.referenceDate))] = [abundanceCard, academyCard]

        self.viewModel = CardsGridViewModel(cardsBySet: self.cardsBySet)
    }

    private func setupNewViewModel() {
        let abominationCard = Card(id: "aef2b3de-ed09-591e-ac6b-ecf62bac4a6b",
                                    name: "Abomination of Gudul",
                                    imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=386463&type=card",
                                    types: ["Creature"])
        abominationCard.imageData = UIImage(named: "cardForTest")?.pngData()

        self.cardsBySet[CardSet(id: "KTK", name: "Khans of Tarkir", releaseDate: Date(timeInterval: 10.0, since: self.referenceDate))] = [abominationCard]

        self.viewModel = CardsGridViewModel(cardsBySet: self.cardsBySet)
    }

    // MARK: Tear down

    override func tearDown() {
        self.referenceDate = nil
        self.cardsBySet = nil
        self.viewModel = nil
        self.sut = nil
    }

    // MARK: Tests

    func testLookAndFeel() {
        expect(self.sut) == recordSnapshot("CardsGridView_initialViewModel")
    }

    func testViewModelUpdate() {
        self.setupNewViewModel()
        self.sut.viewModel = self.viewModel
        expect(self.sut) == recordSnapshot("CardsGridView_newViewModel")
    }
}
