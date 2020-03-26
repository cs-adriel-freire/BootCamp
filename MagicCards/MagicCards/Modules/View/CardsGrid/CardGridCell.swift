//
//  CardGridCell.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 16/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Kingfisher
import SnapKit
import UIKit

final class CardGridCell: UICollectionViewCell {

    // MARK: - Variables

    // MARK: Reuse Identifier

    static let reuseIdentifier: String = "CardGridCell"

    // MARK: Subviews

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 10)
        view.textColor = .black
        view.numberOfLines = 4
        view.textAlignment = .center
        return view
    }()

    // MARK: Operation task

    private var operationTask: OperationTask?

    // MARK: - Methods

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.operationTask = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration

    func configure(with viewModel: CardCellViewModel, imageFetcher: ImageFetcher) {
        self.operationTask = imageFetcher.fetchImage(for: self.imageView,
                                                     withUrl: viewModel.imageUrl,
                                                     placeholder: UIImage(named: "cardPlaceholder")) { error in
            if error != nil {
                self.imageView.image = UIImage(named: "emptyCard")
                self.nameLabel.text = viewModel.name
            } else {
                self.nameLabel.text = nil
            }
        }
    }

    override func prepareForReuse() {
        self.operationTask?.cancel()
        self.imageView.image = nil
        self.nameLabel.text = nil
    }
}

// MARK: - ViewCode

extension CardGridCell: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(self.imageView)
        self.addSubview(self.nameLabel)
    }
    
    func setupContraints() {
        self.imageView.snp.makeConstraints { maker in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }

        self.nameLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(16)
            maker.centerX.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.layer.cornerRadius = 5.0
        self.layer.masksToBounds = true
    }
}
