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
        viewModel.getNumberOfSections()
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        let view: UICollectionReusableView
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: GridCollectionHeaderView.reuseIdentifier,
                                                                               for: indexPath) as? GridCollectionHeaderView else {
                                                                                return UICollectionReusableView()
        }
        
        headerView.configure(with: self.viewModel.getHeaderTitle(forSection: indexPath.section))
        view = headerView
        return view
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardCell.reuseIdentifier, for: indexPath) as? CardCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(with: self.viewModel.viewModelBySection[0][0])

        return cell
    }
}
