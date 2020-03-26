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

    // MARK: - Variables
    private let indicator = UIActivityIndicatorView(style: .whiteLarge)
    private var firstTimeLoading = true
    private var isMakingResquest = false
    var gotLastSet: Bool

    // MARK: View

    private lazy var gridView = CardsGridView(viewModel: self.viewModel, collectionDelegate: self)

    // MARK: ViewModel

    private var viewModel = CardsGridViewModel(cardsBySet: [:]) {
        didSet {
            self.gridView.viewModel = self.viewModel
            DispatchQueue.main.async {
                self.indicator.stopAnimating()
            }
        }
    }

    // MARK: Data

    let cardsRepository: Repository

    // MARK: Delegate

    weak var delegate: CardsViewControllerDelegate?

    // MARK: - Methods
    private func setUpActivityIndicator() {
        if firstTimeLoading {
            firstTimeLoading = false
            indicator.center = view.center
            self.view.addSubview(indicator)
            indicator.startAnimating()
        }
        
    }
    
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
        setUpActivityIndicator()
    }

    // MARK: Update data

    private func getMoreCards() {
        if !isMakingResquest {
            isMakingResquest = true
            self.cardsRepository.getCards(untilSet: self.viewModel.nextSectionIndex) { result in
                switch result {
                case let .success(cardsBySet):
                    self.viewModel = CardsGridViewModel(cardsBySet: cardsBySet)
                case let .failure(error):
                    if let cardsRepositoryError = error as? CardsRepositoryError, cardsRepositoryError == CardsRepositoryError.setNotFound {
                        self.gotLastSet = true
                    }
                    print(error)
                }
                self.isMakingResquest = false
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
        self.getMoreCards()    }
}
