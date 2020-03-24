//
//  CardsRepositoryDummy.swift
//  MagicCardsTests
//
//  Created by lucca.f.ferreira on 19/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

@testable import MagicCards

final class CardsRepositoryDummy: CardDetailsRepositoryProtocol, CardsRepositoryProtocol {

    func getCard(fromSet setIndex: Int, withIndex cardIndex: Int, completion: @escaping (Result<Card, Error>) -> Void) { }

    func getCards(untilSet setIndex: Int, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void) { }
}
