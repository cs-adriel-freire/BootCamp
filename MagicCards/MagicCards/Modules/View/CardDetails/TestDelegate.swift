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
}
