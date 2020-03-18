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
    
    static var decoder: JSONDecoder {
        let decoder = JSONDecoder()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        decoder.dateDecodingStrategy = .formatted(dateFormatter)
        return decoder
    }
    
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
