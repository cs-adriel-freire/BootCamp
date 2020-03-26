//
//  CardDetailsView.swift
//  MagicCardsSnapshotTests
//
//  Created by Adriel de Arruda Moura Freire on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import Nimble
import Nimble_Snapshots
import XCTest

@testable import MagicCards

final class CardDetailsViewTest: XCTestCase {
    private var sut: CardDetailsView!
    private var imageFetcher: ImageFetcherStub!
    
    override func setUp() {
        super.setUp()
        self.imageFetcher = ImageFetcherStub()
        let viewModel = CardDetailsViewModel(cards: [setInitialCard()])
        sut = CardDetailsView(frame: CGRect(x: 0, y: 0, width: 375, height: 667), viewModel: viewModel, imageFetcher: self.imageFetcher)
    }
    
    override func tearDown() {
        sut = nil
        self.imageFetcher = nil
        super.tearDown()
    }
    
    func testLookAndFeel() {
        expect(self.sut).to( haveValidSnapshot(named: "CardDetailsView") )
    }

    func testLookAndFeelWithoutImage() {
        let viewModel = CardDetailsViewModel(cards: [Card(id: "001", name: "Test Card", imageUrl: nil, types: [])])
        self.imageFetcher.shouldReturnError = true
        sut = CardDetailsView(frame: CGRect(x: 0, y: 0, width: 375, height: 667), viewModel: viewModel, imageFetcher: self.imageFetcher)

        expect(self.sut).to( haveValidSnapshot(named: "CardDetailsView_withoutImage") )
    }
    
    private func setInitialCard() -> Card {
        return Card(id: "001", name: "Test Card", imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?name=Test%20Card&type=card", types: [])
    }
}
