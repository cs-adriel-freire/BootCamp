//
//  FavoriteCardsRepositoryProtocol.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 17/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

protocol FavoriteCardsRepositoryProtocol {

    // MARK: Get methods

    func getFavoriteCards() -> [Card]    // TODO: Remove this temporary solution
    // func getFavoriteCards(untilSet setIndex: Int) -> [CardSet: [Card]]
    func getFavoriteCards(untilSet setIndex: Int, withName: String) -> [CardSet: [Card]]

    // MARK: Favorite methods

    func addCardToFavorie(_ card: Card)
    func removeCardFromFavorite(_ card: Card)
}
