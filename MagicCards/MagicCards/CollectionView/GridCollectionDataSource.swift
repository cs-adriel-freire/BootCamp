//
//  GridCollectionDataSource.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class GridCollectionDataSource: NSObject {

    // MARK: - Variables

    // MARK: UICollectionViewDataSource protocol

    var viewModel: CardsGridViewModel

    // MARK: - Methods

    // MARK: Initializers

    init(viewModel: CardsGridViewModel) {
        self.viewModel = viewModel
        super.init()
    }
}

// MARK: - UICollectionViewDataSource

extension GridCollectionDataSource: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.numberOfSections
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItemsBySection[section]
    }

    //swiftlint:disable line_length
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        //swiftlint:enable line_length

        let view: UICollectionReusableView
        switch kind {
        case UICollectionView.elementKindSectionHeader:
            guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                                   withReuseIdentifier: GridCollectionHeaderView.reuseIdentifier,
                                                                                   for: indexPath) as? GridCollectionHeaderView else {
                return UICollectionReusableView()
            }

            headerView.configure(with: self.viewModel.headerTitleBySection[indexPath.section])
            view = headerView
        default:
            view = UICollectionReusableView()
        }

        return view
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardGridCell.reuseIdentifier, for: indexPath) as? CardGridCell else {
            return UICollectionViewCell()
        }

        cell.configure(with: self.viewModel.cellViewModelBySection[indexPath.section][indexPath.row])

        return cell
    }
}
