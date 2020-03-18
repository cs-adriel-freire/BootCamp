//
//  Card.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 14/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

class Card: Codable {
    
    let id: String
    let name: String
    let imageUrl: String?
    var imageData: Data?
    let types: [String]

}
