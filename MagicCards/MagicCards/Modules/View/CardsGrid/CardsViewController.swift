//
//  CardsViewController.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class CardsViewController: UIViewController {
    typealias Repository = CardsRepositoryProtocol & CardDetailsRepositoryProtocol
    
    enum State {
        case initial
        case error
        case loading
        case success
    }

    // MARK: - Variables
    private var gotLastSet: Bool
    private var state: State = .initial {
        didSet {
            self.gridView.setState(state)
        }
    }

    // MARK: View

    private lazy var gridView = CardsGridView(viewModel: self.viewModel, collectionDelegate: self, errorViewDelegate: self)

    // MARK: ViewModel

    private var viewModel = CardsGridViewModel(cardsBySet: [:]) {
        didSet {
            self.gridView.viewModel = self.viewModel
        }
    }

    // MARK: Data

    let cardsRepository: Repository

    // MARK: Delegate

    weak var delegate: CardsViewControllerDelegate?

    // MARK: - Methods
    
    // MARK: Initializers

    init(repository: Repository) {
        self.cardsRepository = repository
        self.gotLastSet = false
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle

    override func loadView() {
        self.view = self.gridView
        self.gridView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMoreCards()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    // MARK: Update data

    private func getMoreCards() {
        self.state = .loading
        self.cardsRepository.getCards(untilSet: self.viewModel.nextSectionIndex) { result in
            switch result {
            case let .success(cardsBySet):
                self.viewModel = CardsGridViewModel(cardsBySet: cardsBySet)
                self.state = .success
            case let .failure(error):
                if let cardsRepositoryError = error as? CardsRepositoryError, cardsRepositoryError == CardsRepositoryError.setNotFound {
                    self.gotLastSet = true
                }
                self.state = .error
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension CardsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard !self.gotLastSet else {
            return
        }

        if indexPath == IndexPath(item: self.viewModel.lastSectionCount-1, section: self.viewModel.nextSectionIndex-1) {
            self.getMoreCards()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let card = viewModel.getItens(forSection: indexPath.section, row: indexPath.row)
        self.delegate?.showDetails(forCard: card)
    }
}

// MARK: - CardsGridViewDelegate

extension CardsViewController: CardsGridViewDelegate {

    func refresh() {
        self.cardsRepository.reset()
        self.viewModel = CardsGridViewModel(cardsBySet: [:])
        self.getMoreCards()
    }
}

// MARK: - CardsGridErrorViewDelegate

extension CardsViewController: CardsGridErrorViewDelegate {
    
    func retryFetchAction() {
        self.getMoreCards()
    }

}

// MARK: - UIScrollViewDelegate

extension CardsViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.height
        let contentSizeHeight = scrollView.contentSize.height
        let offset = scrollView.contentOffset.y
        let reachedBottom = (offset + height >= contentSizeHeight - 10)
        
        if reachedBottom && contentSizeHeight != 0 && !self.gotLastSet {
            self.gridView.footerView.isHidden = false
        } else {
            self.gridView.footerView.isHidden = true
        }
    }
}
