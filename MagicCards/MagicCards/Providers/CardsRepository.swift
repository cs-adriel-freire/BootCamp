//
//  CardsRepository.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 17/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

final class CardsRepository {

    // MARK: - Variables

    // MARK: Data

    private var cardSets: [CardSet]
    private var cards: [CardSet: [Card]]

    // MARK: Providers

    private let cardsProvider: CardsProvider

    // MARK: - Methods

    // MARK: Initializers

    init(cardsProvider: CardsProvider = MagicAPIProvider()) {
        self.cardsProvider = cardsProvider
        self.cardSets = []
        self.cards = [:]
    }

    // MARK: Helpers

    private func fetchCards(fromSet set: CardSet, completion: @escaping (Result<[Card], Error>) -> Void) {
        self.cardsProvider.fetchCards(withSet: set.id) { [weak self] result in
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
            self.cardsProvider.fetchCardSets { [weak self] result in
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

    func reset() {
        self.cardSets = []
        self.cards = [:]
    }

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

// MARK: - Error enum

enum CardsRepositoryError: Error {
    case setNotFound
    case cardNotFound
}
