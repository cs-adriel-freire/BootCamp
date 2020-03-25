//
//  CardsGridView.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 17/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import SnapKit
import UIKit

final class CardsGridView: UIView {

    // MARK: - Variables

    // MARK: ViewModel

    var viewModel: CardsGridViewModel {
        didSet {
            self.gridCollectionDataSource.viewModel = self.viewModel
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

    // MARK: Delegate

    weak var delegate: CardsGridViewDelegate?

    // MARK: CollectionVIew

    var collectionFlowLayout: CardsGridViewFlowLayout
    private let gridCollectionDataSource: GridCollectionDataSource
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
        view.register(CardGridCell.self, forCellWithReuseIdentifier: CardGridCell.reuseIdentifier)
        view.register(GridCollectionHeaderView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: GridCollectionHeaderView.reuseIdentifier)
        view.dataSource = self.gridCollectionDataSource
        view.delegate = self.collectionViewDelegate
        view.backgroundColor = .clear
        return view
    }()

    private lazy var refreshControl: UIRefreshControl = {
        let view = UIRefreshControl()
        view.tintColor = .white
        view.attributedTitle = NSAttributedString(string: "Pull down to refresh", attributes: [NSAttributedString.Key.foregroundColor: UIColor.white,
                                                                                               NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)])
        view.addTarget(self, action: #selector(self.refreshCollectionView), for: .valueChanged)
        self.collectionView.refreshControl = view
        return view
    }()

    // MARK: - Methods

    // MARK: Initializers

    init(frame: CGRect = .zero, viewModel: CardsGridViewModel, collectionDelegate: UICollectionViewDelegate? = nil) {
        self.viewModel = viewModel
        self.collectionViewDelegate = collectionDelegate
        self.collectionFlowLayout = CardsGridViewFlowLayout()
        self.gridCollectionDataSource = GridCollectionDataSource(viewModel: self.viewModel)
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

    // MARK: Refresh

    @objc func refreshCollectionView() {
        self.collectionView.refreshControl?.endRefreshing()
        self.delegate?.refresh()
    }
}

// MARK: - ViewCode

extension CardsGridView: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(self.backgroundImageView)
        self.addSubview(collectionView)
        self.collectionView.addSubview(self.refreshControl)
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
        //
    }
}
