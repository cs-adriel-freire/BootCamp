//
//  CardsViewControllerDelegate.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 23/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Foundation

protocol CardsViewControllerDelegate: AnyObject {

    func showDetails(forCard card: Card)
}
