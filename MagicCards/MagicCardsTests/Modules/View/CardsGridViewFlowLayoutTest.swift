//
//  CardsGridViewFlowLayoutTest.swift
//  MagicCardsTests
//
//  Created by lucca.f.ferreira on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import XCTest

@testable import MagicCards

class CardsGridViewFlowLayoutTest: XCTestCase {

    // MARK: - Variables
    
    var sut: CardsGridViewFlowLayout!
    var cellSize: CGSize!
    var minimumMargin: CGFloat!
    var scrollDirection: UICollectionView.ScrollDirection!
    
    // MARK: - Methods

    // MARK: Set up
    
    override func setUp() {
        cellSize = CGSize(width: 80, height: 100)
        minimumMargin = 16.0
        scrollDirection = .vertical
        sut = CardsGridViewFlowLayout(cellSize: cellSize, minimumMargin: minimumMargin, scrollDirection: scrollDirection)
    }
    
    // MARK: Tear down

    override func tearDown() {
        sut = nil
    }
    
    // MARK: Tests
    
    func testInitialization() {
        XCTAssert(sut.cellSize == cellSize)
        XCTAssert(sut.minimumMargin == minimumMargin)
        XCTAssert(sut.scrollDirection == scrollDirection)
    }
    
    func testMarginForFrame() {
        let frame = CGRect(x: 0, y: 0, width: 430, height: 900)
        var dummyCollectionView: UICollectionView = UICollectionView(frame: frame, collectionViewLayout: sut)
        dummyCollectionView.collectionViewLayout.invalidateLayout()
        XCTAssert(sut.minimumLineSpacing == 22)
        XCTAssert(sut.minimumInteritemSpacing == 22)
    }

}
