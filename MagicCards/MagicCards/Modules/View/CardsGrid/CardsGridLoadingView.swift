//
//  CardsGridLoadingView.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 25/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class CardsGridLoadingView: UIView {

    // MARK: - Variables
    
    // MARK: Subviews
    
    private lazy var activityView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.style = .whiteLarge
        view.startAnimating()
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
}

// MARK: - ViewCode

extension CardsGridLoadingView: ViewCode {
    
    func buildViewHierarchy() {
        self.addSubview(self.activityView)
    }
    
    func setupContraints() {
        self.activityView.snp.makeConstraints { (maker) in
            maker.height.width.equalTo(100)
            maker.center.equalToSuperview()
        }
    }
    
    func setupAdditionalConfiguration() {
        //
    }
}

