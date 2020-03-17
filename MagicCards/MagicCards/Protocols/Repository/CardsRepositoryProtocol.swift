//
//  CardsRepositoryProtocol.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 17/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

protocol CardsRepositoryProtocol {

    func getCards(fromSet setIndex: Int, completion: @escaping (Result<[Card], Error>) -> Void)
    func getCards(fromSet setIndex: Int, withName: String, completion: @escaping (Result<[Card], Error>) -> Void)
}
