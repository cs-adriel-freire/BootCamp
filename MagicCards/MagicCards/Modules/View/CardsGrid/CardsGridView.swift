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

    // MARK: CollectionView
    
    private let gridCollectionDataSource: GridCollectionDataSource
    // swiftlint:disable weak_delegate
    private let errorViewDelegate: CardsGridErrorViewDelegate?
    // swiftlint:enable weak_delegate

    // MARK: Subviews

    private lazy var backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "background")
        return view
    }()

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.register(CardGridCell.self, forCellWithReuseIdentifier: CardGridCell.reuseIdentifier)
        view.register(GridCollectionHeaderView.self,
                      forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                      withReuseIdentifier: GridCollectionHeaderView.reuseIdentifier)
        view.dataSource = self.gridCollectionDataSource
        view.delegate = self
        view.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 60, right: 16)
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
         errorViewDelegate: CardsGridErrorViewDelegate? = nil) {
        self.viewModel = viewModel
        self.errorViewDelegate = errorViewDelegate
        self.gridCollectionDataSource = GridCollectionDataSource(viewModel: self.viewModel)
        super.init(frame: frame)

        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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

// MARK: - UICollectionViewDelegate
 
extension CardsGridView: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = viewModel.getItens(forSection: indexPath.section, row: indexPath.row)
        self.delegate?.showDetails(forCard: card)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CardsGridView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 85.0, height: 118.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16.0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if self.viewModel.checkIfSet(section: section) {
            return UIEdgeInsets(top: 0, left: 0, bottom: 4, right: 0)
        } else {
            return UIEdgeInsets(top: 4, left: 0, bottom: 16, right: 0)
        }
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let label = UILabel()
        label.text = self.viewModel.getHeader(forSection: section)
        if self.viewModel.checkIfSet(section: section) {
            label.font = UIFont.systemFont(ofSize: 36, weight: .black)
            label.numberOfLines = 2
        } else {
            label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
            label.numberOfLines = 1
        }
        let maximumLabelSize: CGSize = CGSize(width: collectionView.frame.width, height: .greatestFiniteMagnitude)
        let expectedLabelSize: CGSize = label.sizeThatFits(maximumLabelSize)
        return CGSize(width: collectionView.frame.width, height: expectedLabelSize.height)
    }
}

// MARK: - UIScrollViewDelegate

extension CardsGridView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.height
        let contentSizeHeight = scrollView.contentSize.height
        let offset = scrollView.contentOffset.y
        let reachedBottom = (offset + height >= contentSizeHeight - 10)
        
        if reachedBottom && contentSizeHeight != 0 {
            self.delegate?.reachedBottom()
        } else {
            self.footerView.setHidden(true)
        }
    }
}
