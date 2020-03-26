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

    private let titleLabel = UILabel()

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
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 36.0, weight: .bold)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
    }
    
    func groupConfigure(with title: String) {
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
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
            maker.bottom.equalToSuperview().inset(2)
            maker.left.right.equalToSuperview()
            maker.top.equalToSuperview().offset(6)
        }
    }

    func setupAdditionalConfiguration() {
        //
    }
}
