//
//  CardsRepository.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 17/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

///////////////////////////////

// TODO: Remove these temporary protocols

protocol SessionProvider {

    func fetchCards(withSet set: String, completion: @escaping (Result<[Card], Error>) -> Void)
    func fetchCards(withName name: String, completion: @escaping (Result<[Card], Error>) -> Void)
    func fetchCardSets(completion: @escaping (Result<[CardSet], Error>) -> Void)
}

protocol StorageProvider {

    func fetch() -> [Card]
}

///////////////////////////////

class CardsRepository {

    // MARK: - Variables

    // MARK: Data

    var cardSets: [CardSet]
    var cards: [CardSet: [Card]]
    var favoriteCards: [CardSet: [Card]]

    // MARK: Providers

    let sessionProvider: SessionProvider
    let storageProvider: StorageProvider

    // MARK: - Methods

    // MARK: Initializers

    init(sessionProvider: SessionProvider, storageProvider: StorageProvider) {  // TODO: set default values
        self.sessionProvider = sessionProvider
        self.storageProvider = storageProvider
        self.cardSets = []
        self.cards = [:]
        self.favoriteCards = [:]
    }
}

// MARK: - CardsRepositoryProtocol

extension CardsRepository: CardsRepositoryProtocol {

    func getCards(fromSet setIndex: Int, completion: @escaping (Result<[Card], Error>) -> Void) {
        //
    }

    func getCards(fromSet setIndex: Int, withName: String, completion: @escaping (Result<[Card], Error>) -> Void) {
        //
    }
}

// MARK: - FavoriteCardsRepositoryProtocol

extension CardsRepository: FavoriteCardsRepositoryProtocol {

    func getFavoriteCards(fromSet setIndex: Int, completion: @escaping (Result<[Card], Error>) -> Void) {
        //
    }

    func getFavoriteCards(fromSet setIndex: Int, withName: String, completion: @escaping (Result<[Card], Error>) -> Void) {
        //
    }
}

// MARK: - CardDetailsRepositoryProtocol

extension CardsRepository: CardDetailsRepositoryProtocol {

    func getCard(fromSet setIndex: Int, withIndex cardIndex: Int, completion: @escaping (Result<Card, Error>) -> Void) {
        //
    }
}
