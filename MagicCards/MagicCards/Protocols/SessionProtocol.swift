//
//  SessionProtocol.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol SessionProtocol {
    
    func dataTask(with url: URL) -> URLSessionDataTask
    
}
