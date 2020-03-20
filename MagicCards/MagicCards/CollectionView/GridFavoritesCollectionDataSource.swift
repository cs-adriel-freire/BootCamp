//
//  GridFavoritesCollectionDataSource.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 19/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class GridFavoritesCollectionDataSource: NSObject {

    // MARK: - Variables

    // MARK: UICollectionViewDataSource protocol

    var viewModel: CardsFavoritesGridViewModel

    // MARK: - Methods

    // MARK: Initializers

    init(viewModel: CardsFavoritesGridViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}

// MARK: - UICollectionViewDataSource

extension GridFavoritesCollectionDataSource: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardGridCell.reuseIdentifier, for: indexPath) as? CardGridCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: self.viewModel.cardCellsViewModel[indexPath.row])

        return cell
    }
}
