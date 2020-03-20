//
//  CardsGridErrorView.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 20/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class CardsGridErrorView: UIView {

    // MARK: - Variables
    
    // MARK: Subviews
    
    private let wrapperView: UIView = {
        let view = UIView(frame: .zero)
        return view
    }()
    
    private let mainText: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 12.0, weight: .semibold)
        view.textAlignment = .center
        view.text = "Sorry, something went wrong"
        return view
    }()
    
    private let secondaryText: UILabel = {
        let view = UILabel(frame: .zero)
        view.font = UIFont.systemFont(ofSize: 10.0, weight: .regular)
        view.textAlignment = .center
        view.text = "Press the buttom bellow to try again"
        return view
    }()
    
    private let retryButton: UIButton = {
        let view = UIButton(frame: .zero)
        // view.setImage(nil, for: .normal)
        return view
    }()
    
}


// MARK: - ViewCode

extension CardsGridErrorView: ViewCode {
    
    func buildViewHierarchy() {
        self.addSubview(wrapperView)
        self.wrapperView.addSubview(mainText)
        self.wrapperView.addSubview(secondaryText)
        self.wrapperView.addSubview(retryButton)
    }
    
    func setupContraints() {
        
    }
    
    func setupAdditionalConfiguration() {
    
    }
    
}
