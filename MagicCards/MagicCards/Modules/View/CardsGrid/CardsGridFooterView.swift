//
//  CardsGridFooterView.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 25/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class CardsGridFooterView: UIView {
    
    enum State {
        case loading
        case error
    }
    
    // MARK: - Variables
    
    var state: State = .loading {
        didSet {
            if state == .loading {
                self.failedText.isHidden = true
                self.indicator.isHidden = false
                self.indicator.startAnimating()
                
            } else if state == .error {
                self.indicator.isHidden = true
                self.failedText.isHidden = false
            }
        }
    }
    
    // MARK: Subviews
    
    private let indicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(frame: .zero)
        view.style = .white
        return view
    }()
    
    private let failedText: UILabel = {
        let view = UILabel(frame: .zero)
        view.text = "Sorry, failed to get more Magic sets.\n Check your internet connection."
        view.textAlignment = .center
        view.textColor = .white
        view.numberOfLines = 2
        view.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return view
    }()
    
    // MARK: - Methods
    
    // MARK: Initializer
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setHidden(_ isHidden: Bool) {
        DispatchQueue.main.async {
            if isHidden {
                UIView.animate(withDuration: 0.3, animations: {
                    self.alpha = 0.0
                }) { (success) in
                    if success {
                        self.isHidden = true
                    }
                }
            } else {
                self.isHidden = false
                UIView.animate(withDuration: 0.3) {
                    self.alpha = 1.0
                }
            }
        }
    }
    
}

// MARK: - ViewCode

extension CardsGridFooterView: ViewCode {
    
    func buildViewHierarchy() {
        self.addSubview(self.indicator)
        self.addSubview(self.failedText)
    }
    
    func setupContraints() {
        self.indicator.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.size.equalTo(60)
        }
        self.failedText.snp.makeConstraints { (maker) in
            maker.center.equalToSuperview()
            maker.width.equalToSuperview().multipliedBy(0.8)
        }
    }
    
    func setupAdditionalConfiguration() {
        self.backgroundColor = .clear
    }
}
