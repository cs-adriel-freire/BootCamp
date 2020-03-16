//
//  ViewCode.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 13/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

protocol ViewCode {
    
    func buildViewHierarchy()
    func setupContraints()
    func setupAdditionalConfiguration()
    func setupView()
    
}

extension ViewCode {
    
    func setupView() {
        buildViewHierarchy()
        setupContraints()
        setupAdditionalConfiguration()
    }
    
}
