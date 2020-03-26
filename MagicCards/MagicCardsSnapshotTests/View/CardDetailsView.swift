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

class CardDetailsViewTest: XCTestCase {
    private var sut: CardDetailsView!
    
    override func setUp() {
        super.setUp()
        let viewModel = CardDetailsViewModel(cards: [setInitialCard()])
        sut = CardDetailsView(frame: CGRect(x: 0, y: 0, width: 375, height: 667), viewModel: viewModel)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testLookAndFeel() {
        expect(self.sut).to( haveValidSnapshot(named: "CardDetailsView") )
    }

    func testLookAndFeelWithoutImage() {
        let viewModel = CardDetailsViewModel(cards: [Card(id: "001", name: "Test Card", imageUrl: nil, imageData: nil, types: [])])
        sut = CardDetailsView(frame: CGRect(x: 0, y: 0, width: 375, height: 667), viewModel: viewModel)

        expect(self.sut).to( haveValidSnapshot(named: "CardDetailsView_withoutImage") )
    }
    
    private func setInitialCard() -> Card {
        let image = UIImage(named: "cardForTest")
        return Card(id: "001", name: "Test Card", imageUrl: nil, imageData: image?.pngData(), types: [])
    }
}
