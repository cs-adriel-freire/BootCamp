//
//  GridCollectionHeaderView.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import SnapKit
import UIKit

final class GridCollectionHeaderView: UICollectionReusableView {

    // MARK: - Variables

    // MARK: Reuse Identifier

    static let reuseIdentifier: String = "GridCollectionHeaderView"

    // MARK: Subviews

    private lazy var titleLabel: UILabel = {
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 36.0, weight: .bold)
        view.numberOfLines = 2
        view.textColor = .white
        return view
    }()

    // MARK: - Methods

    // MARK: Initializers

    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        self.setupView()        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Configure

    func configure(with title: String) {
        self.titleLabel.text = title
    }
    
    func newConfigure(with title: String) {
        configure(with: title)
        titleLabel.font = .boldSystemFont(ofSize: 16)
        titleLabel.textColor = .gray
    }

    override func prepareForReuse() {
        self.titleLabel.text = nil
    }
}

// MARK: - ViewCode

extension GridCollectionHeaderView: ViewCode {
    func buildViewHierarchy() {
        self.addSubview(self.titleLabel)
    }

    func setupContraints() {
        self.titleLabel.snp.makeConstraints { maker in
            maker.leading.trailing.equalToSuperview().inset(16)
            maker.top.greaterThanOrEqualToSuperview().inset(8)
            maker.bottom.equalToSuperview().inset(8)
        }
    }

    func setupAdditionalConfiguration() {
        //
    }
}
