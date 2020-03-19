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

enum CardsRepositoryError: Error {
    case setNotFound
    case cardNotFound
}

final class CardsRepository {

    // MARK: - Variables

    // MARK: Data

    private var cardSets: [CardSet]
    private var cards: [CardSet: [Card]]
    private var favoriteCards: [CardSet: [Card]]

    // MARK: Providers

    private let sessionProvider: SessionProvider
    private let storageProvider: StorageProvider

    // MARK: - Methods

    // MARK: Initializers

    init(sessionProvider: SessionProvider, storageProvider: StorageProvider) {  // TODO: set default values
        self.sessionProvider = sessionProvider
        self.storageProvider = storageProvider
        self.cardSets = []
        self.cards = [:]
        self.favoriteCards = [:]
    }

    // MARK: Helpers

    private func fetchCards(fromSet set: CardSet, completion: @escaping (Result<[Card], Error>) -> Void) {
        self.sessionProvider.fetchCards(withSet: set.id) { [weak self] result in
            switch result {
            case let .success(cards):
                self?.cards[set] = cards
                completion(.success(cards))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    private func getCardSet(withIndex setIndex: Int, completion: @escaping (Result<CardSet, Error>) -> Void) {

        // If the cardSets are not stored locally, fetch them

        guard !self.cardSets.isEmpty else {
            self.sessionProvider.fetchCardSets { [weak self] result in
                switch result {
                case let .success(cardSets):
                    self?.cardSets = cardSets.sorted(by: { (lhs, rhs) in
                        lhs.releaseDate > rhs.releaseDate
                    })
                    self?.getCardSet(withIndex: setIndex, completion: completion)
                case let .failure(error):
                    completion(.failure(error))
                }
            }

            return
        }

        // Validate index

        guard setIndex < self.cardSets.count else {
            completion(.failure(CardsRepositoryError.setNotFound))
            return
        }

        completion(.success(self.cardSets[setIndex]))
    }

    private func getCards(fromSet setIndex: Int, completion: @escaping (Result<[Card], Error>) -> Void) {

        self.getCardSet(withIndex: setIndex) { result in
            switch result {
            case let .success(cardSet):

                guard let cards = self.cards[cardSet] else {
                    self.fetchCards(fromSet: cardSet, completion: completion)
                    return
                }

                completion(.success(cards))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

// MARK: - CardsRepositoryProtocol

extension CardsRepository: CardsRepositoryProtocol {

    func getCards(untilSet setIndex: Int, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void) {

        self.getCardSet(withIndex: setIndex) { result in
            switch result {
            case let .success(cardSet):

                guard self.cards[cardSet] != nil else {
                    self.fetchCards(fromSet: cardSet) { result in
                        switch result {
                        //swiftlint:disable empty_enum_arguments
                        case .success(_):
                        // swiftlint:enable empty_enum_arguments
                            completion(.success(self.cards))
                        case let .failure(error):
                            completion(.failure(error))
                        }
                    }
                    return
                }

                completion(.success(self.cards))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getCards(untilSet setIndex: Int, withName: String, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void) {
        //
    }
}

// MARK: - FavoriteCardsRepositoryProtocol

extension CardsRepository: FavoriteCardsRepositoryProtocol {

    func getFavoriteCards(untilSet setIndex: Int, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void) {
        //
    }

    func getFavoriteCards(untilSet setIndex: Int, withName: String, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void) {
        //
    }
}

// MARK: - CardDetailsRepositoryProtocol

extension CardsRepository: CardDetailsRepositoryProtocol {

    func getCard(fromSet setIndex: Int, withIndex cardIndex: Int, completion: @escaping (Result<Card, Error>) -> Void) {

        self.getCards(fromSet: setIndex) { result in
            switch result {
            case let .success(cards):

                guard cardIndex < cards.count else {
                    completion(.failure(CardsRepositoryError.cardNotFound))
                    return
                }

                completion(.success(cards[cardIndex]))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
