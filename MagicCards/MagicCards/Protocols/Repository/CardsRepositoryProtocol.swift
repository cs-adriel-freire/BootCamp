//
//  CardsRepositoryProtocol.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 17/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

protocol CardsRepositoryProtocol {

    func reset()
    func getCards(untilSet setIndex: Int, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void)
}
