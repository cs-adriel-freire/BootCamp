//
//  CardDetailsCollectionDataSource.swift
//  MagicCards
//
//  Created by Adriel de Arruda Moura Freire on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
final class CardDetailsCollectionDataSource: NSObject, UICollectionViewDataSource {
    var cards: [Card]
    
    init(cards: [Card]) {
        self.cards = cards
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        cards.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell else {
            return UICollectionViewCell()
        }
        let cardCellViewModel = CardCellViewModel(card: cards[indexPath.row])
        cell.configure(with: cardCellViewModel)
        cell.backgroundColor = .green
        return cell
    }
    
}
