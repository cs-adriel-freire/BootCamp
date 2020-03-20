//
//  CardDetailsCell.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 20/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import SnapKit
import UIKit

final class CardDetailsCell: UICollectionViewCell {

    // MARK: - Variables

    // MARK: Reuse Identifier

    static let reuseIdentifier: String = "CardDetailsCell"

    // MARK: Subviews

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .lightGray
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 9)
        view.textColor = .black
        return view
    }()

    // MARK: - Methods

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration

    func configure(with viewModel: CardCellViewModel) {
        self.imageView.image = viewModel.image
        self.nameLabel.text = viewModel.name
    }
}

// MARK: - ViewCode

extension CardDetailsCell: ViewCode {

    func buildViewHierarchy() {
        self.addSubview(self.imageView)
        self.addSubview(self.nameLabel)
    }
    
    func setupContraints() {
        self.imageView.snp.makeConstraints { maker in
            maker.top.bottom.leading.trailing.equalToSuperview()
        }

        self.nameLabel.snp.makeConstraints { maker in
            maker.top.equalToSuperview().inset(17)
            maker.centerX.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.layer.cornerRadius = 10.0
        self.layer.masksToBounds = true
    }
}
