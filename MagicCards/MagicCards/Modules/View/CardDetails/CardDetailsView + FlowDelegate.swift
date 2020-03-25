//
//  TestDelegate.swift
//  MagicCards
//
//  Created by Adriel de Arruda Moura Freire on 19/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

private let cardWidth: CGFloat = 190
private let cardHeight: CGFloat = 264

extension CardDetailsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: cardWidth, height: cardHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let horizontalInset = (collectionView.frame.width - cardWidth) / 2
        let verticalInset = (collectionView.frame.height - cardHeight) / 2

        return UIEdgeInsets(top: verticalInset, left: horizontalInset, bottom: verticalInset, right: horizontalInset)
    }
}
