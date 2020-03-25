//
//  CardDetailsRepositoryProtocol.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 17/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

protocol CardDetailsRepositoryProtocol {

    func getCard(fromSet setIndex: Int, withIndex cardIndex: Int, completion: @escaping (Result<Card, Error>) -> Void)
}
