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

    // MARK: View

    private lazy var gridView = CardsGridView(viewModel: self.viewModel, collectionDelegate: self)

    // MARK: ViewModel

    private var viewModel = CardsGridViewModel(cardsBySet: [:]) {
        didSet {
            self.gridView.viewModel = self.viewModel
        }
    }
    
    private var state: State = .initial {
        didSet {
            self.gridView.setState(state)
        }
    }

    // MARK: Data

    let cardsRepository: Repository

    // MARK: - Methods

    // MARK: Initializers

    init(repository: Repository) {
        self.cardsRepository = repository
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle

    override func loadView() {
        self.view = self.gridView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.getMoreCards()
    }

    override func viewDidLayoutSubviews() {
        self.gridView.updateFrame()
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
            case .failure:
                self.state = .error
            }
        }
    }
}

// MARK: - UICollectionViewDelegate

extension CardsViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath == IndexPath(item: self.viewModel.lastSectionCount-1, section: self.viewModel.nextSectionIndex-1) {
            self.getMoreCards()
        }
    }
}

// MARK: - CardsGridErrorViewDelegate

extension CardsViewController: CardsGridErrorViewDelegate {
    
    func retryFetchAction() {
        self.getMoreCards()
    }

}
