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

    // MARK: Image fetcher

    private var imageFetcher: ImageFetcher

    // MARK: - Methods

    // MARK: Initializers

    init(viewModel: CardsGridViewModel, imageFetcher: ImageFetcher) {
        self.viewModel = viewModel
        self.imageFetcher = imageFetcher
        super.init()
    }
}

// MARK: - UICollectionViewDataSource

extension GridCollectionDataSource: UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        viewModel.getAllHeaders().count
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let itens = viewModel.getAllItens()
        return itens[section].count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String,
                        at indexPath: IndexPath) -> UICollectionReusableView {

        let view: UICollectionReusableView
        guard let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                               withReuseIdentifier: GridCollectionHeaderView.reuseIdentifier,
                                                                               for: indexPath) as? GridCollectionHeaderView else {
                                                                                return UICollectionReusableView()
        }
        if viewModel.checkIfSet(section: indexPath.section) {
            headerView.configure(with: self.viewModel.getHeader(forSection: indexPath.section))
        } else {
            headerView.groupConfigure(with: self.viewModel.getHeader(forSection: indexPath.section))
        }
        view = headerView
        return view
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CardGridCell.reuseIdentifier, for: indexPath) as? CardGridCell else {
            return UICollectionViewCell()
        }
        let card = viewModel.getItens(forSection: indexPath.section, row: indexPath.row)
        let cardViewModel = CardCellViewModel(card: card)
        cell.configure(with: cardViewModel, imageFetcher: self.imageFetcher)

        return cell
    }
}
