//
//  FavoriteCardsRepositoryProtocol.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 17/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

protocol FavoriteCardsRepositoryProtocol {

    func getFavoriteCards(fromSet setIndex: Int, completion: @escaping (Result<[Card], Error>) -> Void)
    func getFavoriteCards(fromSet setIndex: Int, withName: String, completion: @escaping (Result<[Card], Error>) -> Void)
}
