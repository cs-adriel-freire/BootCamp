//
//  CardsProvider.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 19/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

protocol CardsProvider {

    func fetchCards(withName name: String, completion: @escaping (Result<[Card], Error>) -> Void)
    func fetchCards(withSet set: String, completion: @escaping (Result<[Card], Error>) -> Void)
    func fetchCardSets(completion: @escaping (Result<[CardSet], Error>) -> Void)
}
