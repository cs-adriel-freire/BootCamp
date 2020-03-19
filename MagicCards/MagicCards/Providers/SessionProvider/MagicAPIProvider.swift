//
//  MagicAPIProvider.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

final class MagicAPIProvider: SessionProvider {

    // MARK: - Variables

    var urlSession: URLSession
    var requestBuilders: [String: SessionRequestBuilder]
    var decoder: JSONDecoder

    // MARK: - Methods

    // MARK: Initializers

    required init(urlSession: URLSession, requestBuilders: [String: SessionRequestBuilder], decoder: JSONDecoder) {
        self.urlSession = urlSession
        self.requestBuilders = requestBuilders
        self.decoder = decoder
    }

    init() {
        let cardsRequestBuilder = SessionRequestBuilder(baseURL: URL(string: "https://api.magicthegathering.io/v1")!, path: "cards")
        let cardSetsRequestBuilder = SessionRequestBuilder(baseURL: URL(string: "https://api.magicthegathering.io/v1")!, path: "sets")

        var requestBuilders: [String: SessionRequestBuilder] = [:]
        requestBuilders["cards"] = cardsRequestBuilder
        requestBuilders["sets"] = cardSetsRequestBuilder

        let decoder: JSONDecoder = {
            let decoder = JSONDecoder()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            return decoder
        }()

        self.urlSession = URLSession.shared
        self.requestBuilders = requestBuilders
        self.decoder = decoder
    }

    // MARK: Image fetch

    public func fetchImage(toCardUrl urlString: String?, completion: @escaping (Data) -> Void) {
        // TODO: Change this empty data to a specific placeholder image
        let dataPlaceholder: Data = Data()
        guard let urlString = urlString, let url = URL(string: urlString) else {
            completion(dataPlaceholder)
            return
        }
        let request = URLRequest(url: url)
        let task = urlSession.dataTask(with: request) { (data, _, _) in
            guard let data = data else {
                completion(dataPlaceholder)
                return
            }
            completion(data)
        }
        task.resume()
    }

    // MARK: Helpers

    private func pages(forResponse response: URLResponse) -> Int {
        guard let header = response as? HTTPURLResponse else { return 0 }
        guard let totalCountString = header.allHeaderFields["total-count"] as? String else { return 0 }
        guard let totalCount = Double(totalCountString) else { return 0 }
        return Int((totalCount/100).rounded(.up))
    }
    
}

// MARK: - CardsProvider

extension MagicAPIProvider: CardsProvider {

    public func fetchCards(withName name: String, completion: @escaping (Result<[Card], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "fetchCards")
        var cards: [Card] = []
        guard let requestBuilder = requestBuilders["cards"] else {
            // TODO: Change to a valid error return
            return
        }
        
        let params = [URLQueryItem(name: "name", value: name), URLQueryItem(name: "page", value: "1")]
        let request = requestBuilder.request(withParams: params)
    
        dispatchGroup.enter()
        fetch(withRequest: request, decoder: decoder) { (result: Result<(CardDTO, URLResponse), SessionProviderError>) in
            switch result {
            case .success(let (dto, response)):
                cards.append(contentsOf: dto.cards)
                
                for card in dto.cards {
                    dispatchGroup.enter()
                    self.fetchImage(toCardUrl: card.imageUrl) { (data) in
                        card.imageData = data
                        dispatchGroup.leave()
                    }
                }
                
                for page in 2 ... self.pages(forResponse: response) {
                    let params = [URLQueryItem(name: "name", value: name), URLQueryItem(name: "page", value: String(page))]
                    let request = requestBuilder.request(withParams: params)
                    dispatchGroup.enter()
                    self.fetch(withRequest: request, decoder: self.decoder) { (result: Result<(CardDTO, URLResponse), SessionProviderError>) in
                        switch result {
                        case .success(let (dto, _)):
                            cards.append(contentsOf: dto.cards)
                            
                            for card in dto.cards {
                                dispatchGroup.enter()
                                self.fetchImage(toCardUrl: card.imageUrl) { (data) in
                                    card.imageData = data
                                    dispatchGroup.leave()
                                }
                            }
                            
                            dispatchGroup.leave()
                        case .failure(let error):
                            completion(.failure(error))
                            dispatchGroup.leave()
                        }
                    }
                }
                dispatchGroup.leave()
            case .failure(let error):
                completion(.failure(error))
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: dispatchQueue) {
                completion(.success(cards))
            }
        }
    }

    public func fetchCards(withSet set: String, completion: @escaping (Result<[Card], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        let dispatchQueue = DispatchQueue(label: "fetchCards")
        var cards: [Card] = []
        guard let requestBuilder = requestBuilders["cards"] else {
            // TODO: Change to a valid error return
            return
        }
        
        let params = [URLQueryItem(name: "set", value: set), URLQueryItem(name: "page", value: "1")]
        let request = requestBuilder.request(withParams: params)
    
        dispatchGroup.enter()
        fetch(withRequest: request, decoder: decoder) { (result: Result<(CardDTO, URLResponse), SessionProviderError>) in
            switch result {
            case .success(let (dto, response)):
                cards.append(contentsOf: dto.cards)
                
                for card in dto.cards {
                    dispatchGroup.enter()
                    self.fetchImage(toCardUrl: card.imageUrl) { (data) in
                        card.imageData = data
                        dispatchGroup.leave()
                    }
                }
                
                for page in 2 ... self.pages(forResponse: response) {
                    let params = [URLQueryItem(name: "set", value: set), URLQueryItem(name: "page", value: String(page))]
                    let request = requestBuilder.request(withParams: params)
                    dispatchGroup.enter()
                    self.fetch(withRequest: request, decoder: self.decoder) { (result: Result<(CardDTO, URLResponse), SessionProviderError>) in
                        switch result {
                        case .success(let (dto, _)):
                            cards.append(contentsOf: dto.cards)
                            
                            for card in dto.cards {
                                dispatchGroup.enter()
                                self.fetchImage(toCardUrl: card.imageUrl) { (data) in
                                    card.imageData = data
                                    dispatchGroup.leave()
                                }
                            }
                            
                            dispatchGroup.leave()
                        case .failure(let error):
                            completion(.failure(error))
                            dispatchGroup.leave()
                        }
                    }
                }
                dispatchGroup.leave()
            case .failure(let error):
                completion(.failure(error))
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: dispatchQueue) {
                completion(.success(cards))
            }
        }
    }

    public func fetchCardSets(completion: @escaping (Result<[CardSet], Error>) -> Void) {
        guard let requestBuilder = requestBuilders["sets"] else {
            // TODO: Change to a valid error return
            return
        }
        fetch(withRequest: requestBuilder.request(), decoder: decoder) { (result: Result<(CardSetDTO, URLResponse), SessionProviderError>) in
            switch result {
            case .success(let (dto, _)):
                completion(.success(dto.sets))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
