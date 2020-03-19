//
//  CardSet.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 14/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

final class CardSet: Codable {
    
    // MARK: - Variables
    
    let id: String
    let name: String
    let releaseDate: Date
    
    // MARK: - Methods

    // MARK: Initializers
    
    init(id: String, name: String, releaseDate: Date) {
        self.id = id
        self.name = name
        self.releaseDate = releaseDate
    }
    
    // MARK: - Enums
    
    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case name
        case releaseDate
    }
    
}

// MARK: - Hashable

extension CardSet: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.id)
    }
}

// MARK: - Equatable

extension CardSet: Equatable {
    static func == (lhs: CardSet, rhs: CardSet) -> Bool {
        return lhs.id == rhs.id
    }
}
