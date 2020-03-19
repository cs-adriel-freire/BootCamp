//
//  FavoriteCardsGridView.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 19/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class FavoritesCardsGridView: UIView {
    
    // MARK: - Variables

    var viewModel: CardsFavoritesGridViewModel {
        didSet {
            self.gridFavoritesCollectionDataSource.viewModel = self.viewModel
            self.collectionView.reloadData()
        }
    }

    // MARK: CollectionVIew

    var collectionFlowLayout: CardsGridViewFlowLayout
    private let gridFavoritesCollectionDataSource: GridFavoritesCollectionDataSource
    //swiftlint:disable weak_delegate
    private let collectionViewDelegate: UICollectionViewDelegate?
    //swiftlint:enable weak_delegate

    // MARK: Subviews

    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: self.collectionFlowLayout)
        view.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseIdentifier)
        view.dataSource = self.gridFavoritesCollectionDataSource
        view.delegate = self.collectionViewDelegate
        view.backgroundColor = .clear
        return view
    }()

    // MARK: - Methods

    // MARK: Initializers

    init(frame: CGRect = .zero, viewModel: CardsFavoritesGridViewModel, collectionDelegate: UICollectionViewDelegate? = nil) {
        self.collectionViewDelegate = collectionDelegate
        self.viewModel = viewModel
        self.collectionFlowLayout = CardsGridViewFlowLayout()
        self.gridFavoritesCollectionDataSource = GridFavoritesCollectionDataSource(viewModel: self.viewModel)
        super.init(frame: frame)

        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Update
    func updateFrame() {
        self.collectionFlowLayout.collectionFrame = self.collectionView.frame
    }
}

extension FavoritesCardsGridView: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(self.backgroundImageView)
        self.backgroundImageView.addSubview(self.collectionView)
    }

    func setupContraints() {
        self.backgroundImageView.snp.makeConstraints { maker in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }

        self.collectionView.snp.makeConstraints { maker in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {
        self.collectionFlowLayout.collectionFrame = self.frame
    }
}
