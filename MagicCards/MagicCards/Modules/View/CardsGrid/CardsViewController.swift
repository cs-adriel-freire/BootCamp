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
    private var isMakingRequest: Bool = false

    // MARK: View

    private lazy var gridView = CardsGridView(viewModel: self.viewModel, errorViewDelegate: self)

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
        if !self.isMakingRequest {
            self.isMakingRequest = true
            self.state = .loading
            self.cardsRepository.getCards(untilSet: self.viewModel.nextSectionIndex) { result in
                switch result {
                case let .success(cardsBySet):
                    self.viewModel = CardsGridViewModel(cardsBySet: cardsBySet)
                    self.isMakingRequest = false
                    self.state = .success
                case let .failure(error):
                    if let cardsRepositoryError = error as? CardsRepositoryError, cardsRepositoryError == CardsRepositoryError.setNotFound {
                        self.gotLastSet = true
                    }
                    self.isMakingRequest = false
                    self.state = .error
                }
            }
        }
        
    }
}

// MARK: - CardsGridViewDelegate

extension CardsViewController: CardsGridViewDelegate {
    
    func reachedBottom() {
        if !self.gotLastSet {
            self.getMoreCards()
            self.gridView.footerView.setHidden(false)
        } else {
            self.gridView.footerView.setHidden(true)
        }
    }
    
    func showDetails(forCard card: Card) {
        self.delegate?.showDetails(forCard: card)
    }
    
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
