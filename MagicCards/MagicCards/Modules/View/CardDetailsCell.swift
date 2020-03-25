//
//  CardDetailsCell.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 20/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Kingfisher
import SnapKit
import UIKit

final class CardDetailsCell: UICollectionViewCell {

    // MARK: - Variables

    // MARK: Reuse Identifier

    static let reuseIdentifier: String = "CardDetailsCell"

    // MARK: Subviews

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .black
        return view
    }()

    private lazy var nameLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 9)
        view.textColor = .black
        return view
    }()

    // MARK: Download task

    var downloadTask: DownloadTask?

    // MARK: - Methods

    // MARK: Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
        self.downloadTask = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configuration

    func configure(with viewModel: CardCellViewModel) {
        self.downloadTask = self.imageView.kf.setImage(with: viewModel.imageUrl, placeholder: UIImage(named: "cardPlaceholder")) { result in
            if case .failure(_) = result {
                self.imageView.image = UIImage(named: "emptyCard")
                self.nameLabel.text = viewModel.name
            } else {
                self.nameLabel.text = nil
            }
        }
    }

    override func prepareForReuse() {
        self.downloadTask?.cancel()
        self.imageView.image = nil
        self.nameLabel.text = nil
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
