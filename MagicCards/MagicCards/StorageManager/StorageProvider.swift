//
//  StoreManager.swift
//  MagicCards
//
//  Created by Adriel de Arruda Moura Freire on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation
protocol StorageProvider {
    associatedtype Object
    func save(objects: [Object])
    func fetch() -> [Object]
    func reset()
    func delete(objects: [Object])
    var dealWithErrors: () -> Void {get set}
}
