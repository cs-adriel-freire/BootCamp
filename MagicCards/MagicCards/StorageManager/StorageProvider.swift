//
//  StoreManager.swift
//  MagicCards
//
//  Created by Adriel de Arruda Moura Freire on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
protocol StorageProvider {
    func save(objects: [Card])
    func fetch() -> [Card]
    func reset()
    func delete(objects: [Card])
    var dealWithErrors: () -> Void {get set}
}
