//
//  CardSet.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 14/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

struct CardSet: Codable {
    
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
    
    private enum CodingKeys: String, CodingKey {
        case id = "code"
        case name
        case releaseDate
    }
    
}

extension CardSet: Hashable { }
