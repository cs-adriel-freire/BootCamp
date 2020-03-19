//
//  FavoritesViewController.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class FavoritesViewController: UIViewController {
    typealias Repository = FavoriteCardsRepositoryProtocol & FavoriteCardDetailsRepositoryProtocol
    
    // MARK: - Variables
    
    // MARK: View
     private lazy var gridView = FavoritesCardsGridView(viewModel: self.viewModel, collectionDelegate: self)

    // MARK: ViewModel
    private var viewModel: CardsFavoritesGridViewModel = CardsFavoritesGridViewModel(cards: []) {
        didSet {
            self.gridView.viewModel = self.viewModel
        }
    }

    // MARK: Data
    let favoriteCardsRepository: Repository
    
    // MARK: - Methods

    // MARK: Initializers

    init(repository: Repository) {
        self.favoriteCardsRepository = repository
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle
    override func loadView() {
        self.view = self.gridView
    }

    override func viewDidLayoutSubviews() {
        self.gridView.updateFrame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: Update data
    private func getMoreCards() {
        let favoriteCards = self.favoriteCardsRepository.getFavoriteCards()
        self.viewModel = CardsFavoritesGridViewModel(cards: favoriteCards)
    }
    
}

// MARK: - UICollectionViewDelegate
extension FavoritesViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath == IndexPath(item: self.viewModel.numberOfItems - 1, section: 0) {
            self.getMoreCards()
        }
    }
}
