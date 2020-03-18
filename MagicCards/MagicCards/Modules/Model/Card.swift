//
//  Card.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 14/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

final class Card: Codable {
    
    // MARK: - Variables
    
    let id: String
    let name: String
    let imageUrl: String?
    var imageData: Data?
    let types: [String]
    
    // MARK: - Methods

    // MARK: Initializers
    
    init(id: String, name: String, imageUrl: String?, types: [String]) {
        self.id = id
        self.name = name
        self.imageUrl = imageUrl
        self.types = types
    }

}
