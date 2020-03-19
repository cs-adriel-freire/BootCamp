//
//  TestDelegate.swift
//  MagicCards
//
//  Created by Adriel de Arruda Moura Freire on 19/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
extension CardDetailsView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width * (190/320)
        return CGSize(width: width, height: width * 1.3)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        let itemWidth = collectionView.frame.width * (190/320)
        let itemHeight = itemWidth * 1.3
        let inset = (collectionView.frame.height - itemHeight) / 2

        return UIEdgeInsets(top: inset, left: 0, bottom: inset, right: 0)
    }
}
