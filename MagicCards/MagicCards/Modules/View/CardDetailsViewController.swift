//
//  CardDetailsViewController.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class CardDetailsViewController: UIViewController {
    typealias Repository = CardDetailsRepositoryProtocol

    // MARK: - Variables

    // MARK: View

    private lazy var detailsView = CardDetailsView(viewModel: self.viewModel)

    // MARK: ViewModel

    private var viewModel: CardDetailsViewModel {
        didSet {
            self.detailsView.viewModel = self.viewModel
        }
    }

    // MARK: Data

    let repository: Repository

    // MARK: Delegate

    weak var delegate: CardDetailsViewControllerDelegate?

    // MARK: Position

    let set: Int
    let index: Int

    // MARK: - Methods

    // MARK: Initializers

    init(repository: Repository, set: Int, index: Int) {
        self.repository = repository
        self.set = set
        self.index = index
        self.viewModel = CardDetailsViewModel(cards: [])
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Life cycle

    override func loadView() {
        self.view = self.detailsView
        self.detailsView.delegate = self
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.repository.getCard(fromSet: self.set, withIndex: self.index) { result in
            switch result {
            case let .success(card):
                self.viewModel = CardDetailsViewModel(cards: [card])
            case let .failure(error):
                // TOTO: Handle error
                print(error)
            }
        }
    }
}

// MARK: - CardDetailsViewDelegate

extension CardDetailsViewController: CardDetailsViewDelegate {

    func didClickOnCloseButton() {
        self.delegate?.closeDetails()
    }
}
