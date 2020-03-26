//
//  CardDetailsViewController.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class CardDetailsViewController: UIViewController {

    // MARK: - Variables

    // MARK: View

    private lazy var detailsView = CardDetailsView(viewModel: self.viewModel, imageFetcher: self.imageFetcher)

    // MARK: ViewModel

    private var viewModel: CardDetailsViewModel {
        didSet {
            self.detailsView.viewModel = self.viewModel
        }
    }

    // MARK: Data

    let card: Card

    // MARK: Delegate

    weak var delegate: CardDetailsViewControllerDelegate?

    // MARK: Image fetcher

    private var imageFetcher: ImageFetcher

    // MARK: - Methods

    // MARK: Initializers

    init(card: Card, imageFetcher: ImageFetcher) {
        self.card = card
        self.viewModel = CardDetailsViewModel(cards: [card])
        self.imageFetcher = imageFetcher
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

}

// MARK: - CardDetailsViewDelegate

extension CardDetailsViewController: CardDetailsViewDelegate {

    func didClickOnCloseButton() {
        self.delegate?.closeDetails()
    }
}
