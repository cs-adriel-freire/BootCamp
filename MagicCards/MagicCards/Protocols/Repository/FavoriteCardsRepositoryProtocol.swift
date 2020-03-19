//
//  FavoriteCardsRepositoryProtocol.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 17/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

protocol FavoriteCardsRepositoryProtocol {

    func getFavoriteCards(untilSet setIndex: Int, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void)
    func getFavoriteCards(untilSet setIndex: Int, withName: String, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void)
}
