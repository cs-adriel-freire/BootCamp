//
//  CardsViewController.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

////////////////////////

// TODO: remove this

protocol CardsRepositoryProtocol {

    func getCards(untilSet setIndex: Int, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void)
    func getCards(untilSet setIndex: Int, withName: String, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void)
}

class CardsRepository: CardsRepositoryProtocol {
    func getCards(untilSet setIndex: Int, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void) {
        let card = Card(id: "1669af17-d287-5094-b005-4b143441442f",
                        name: "Abundance",
                        imageUrl: "http://gatherer.wizards.com/Handlers/Image.ashx?multiverseid=130483&type=card",
                        types: ["Enchantment"])
        card.imageData = UIImage(named: "cardForTest")?.pngData()

        let referenceDate = Date()
        var cardsBySet = [CardSet(id: "10E",
                                name: "Tenth Edition",
                                releaseDate: Date(timeInterval: 50.0, since: referenceDate)): [card, card, card,
                                                                                               card, card, card,
                                                                                               card, card, card]]

        if setIndex > 0 {
            cardsBySet[CardSet(id: "KTK",
                               name: "Khans of Tarkir",
                               releaseDate: Date(timeInterval: 10.0, since: referenceDate))] = [card, card, card,
                                                                                                card, card, card]
        }

        completion(.success(cardsBySet))
    }

    func getCards(untilSet setIndex: Int, withName: String, completion: @escaping (Result<[CardSet: [Card]], Error>) -> Void) {
        //
    }
}

////////////////////////

import UIKit

final class CardsViewController: UIViewController {

    // MARK: - Variables

    // MARK: View

    private lazy var gridView = CardsGridView(viewModel: self.viewModel, collectionDelegate: self)

    // MARK: ViewModel

    private var viewModel = CardsGridViewModel(cardsBySet: [:]) {
        didSet {
            self.gridView.viewModel = self.viewModel
        }
    }

    // MARK: Data

    let cardsRepository: CardsRepositoryProtocol

    // MARK: - Methods

    // MARK: Initializers

    init(repository: CardsRepositoryProtocol = CardsRepository()) {
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
        self.cardsRepository.getCards(untilSet: self.viewModel.nextSectionIndex) { result in
            switch result {
            case let .success(cardsBySet):
                self.viewModel = CardsGridViewModel(cardsBySet: cardsBySet)
            case let .failure(error):
                print(error)
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
