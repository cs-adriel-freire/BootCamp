//
//  FavoritesRepositoryDummy.swift
//  MagicCardsTests
//
//  Created by lucca.f.ferreira on 19/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

@testable import MagicCards

final class FavoritesRepositoryDummy: FavoriteCardDetailsRepositoryProtocol, FavoriteCardsRepositoryProtocol {
    
    func getCard(withIndex cardIndex: Int, completion: @escaping (Result<Card, Error>) -> Void) { }
    
    func getFavoriteCards() -> [Card] { return [] }
    
    func getFavoriteCards(untilSet setIndex: Int, withName: String) -> [CardSet: [Card]] { return [:] }
    
    func addCardToFavorie(_ card: Card) { }
    
    func removeCardFromFavorite(_ card: Card) { }
}
