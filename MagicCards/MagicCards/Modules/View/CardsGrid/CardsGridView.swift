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
    private let errorViewDelegate: CardsGridErrorViewDelegate?
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
        view.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 60, right: 0)
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
    
    let footerView: CardsGridFooterView = {
        let view = CardsGridFooterView()
        view.isHidden = true
        return view
    }()
    
    private lazy var errorView: CardsGridErrorView = {
        let view = CardsGridErrorView(delegate: self.errorViewDelegate)
        view.isHidden = true
        return view
    }()
    
    private lazy var loadingView: CardsGridLoadingView = {
        let view = CardsGridLoadingView()
        view.isHidden = true
        return view
    }()
    
    // MARK: - Methods

    // MARK: Initializers

    init(frame: CGRect = .zero,
         viewModel: CardsGridViewModel,
         collectionDelegate: UICollectionViewDelegate? = nil,
         errorViewDelegate: CardsGridErrorViewDelegate? = nil,
         imageFetcher: ImageFetcher) {
        self.viewModel = viewModel
        self.collectionViewDelegate = collectionDelegate
        self.errorViewDelegate = errorViewDelegate
        self.collectionFlowLayout = CardsGridViewFlowLayout()
        self.gridCollectionDataSource = GridCollectionDataSource(viewModel: self.viewModel, imageFetcher: imageFetcher)
        super.init(frame: frame)

        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Update

    private func updateFrame() {
        self.collectionFlowLayout.invalidateLayout()
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        self.updateFrame()
    }
    
    func setState(_ state: CardsViewController.State) {
        DispatchQueue.main.async {
            if state == .error && self.viewModel.numberOfItemsBySection.isEmpty {
                self.errorView.isHidden = false
                self.loadingView.isHidden = true
            } else if state == .error && !self.viewModel.numberOfItemsBySection.isEmpty {
                self.footerView.state = .error
            } else if state == .loading && self.viewModel.numberOfItemsBySection.isEmpty {
                self.loadingView.isHidden = false
                self.errorView.isHidden = true
            } else if state == .loading && !self.viewModel.numberOfItemsBySection.isEmpty {
                self.footerView.state = .loading
            } else if state == .success {
                self.errorView.isHidden = true
                self.loadingView.isHidden = true
                self.footerView.setHidden(true)
                self.footerView.state = .loading
            }
        }
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
        self.addSubview(self.footerView)
        self.addSubview(self.collectionView)
        self.addSubview(self.loadingView)
        self.addSubview(self.errorView)
        self.collectionView.addSubview(self.refreshControl)
    }

    func setupContraints() {
        self.backgroundImageView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }

        self.collectionView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        self.footerView.snp.makeConstraints { (maker) in
            maker.left.right.equalTo(self.collectionView)
            maker.bottom.equalTo(self.collectionView)
            maker.height.equalTo(60)
        }
        
        self.loadingView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
        
        self.errorView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }

    func setupAdditionalConfiguration() {
        //
    }
}
