//
//  CardDetailsView.swift
//  MagicCards
//
//  Created by Adriel de Arruda Moura Freire on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
final class CardDetailsView: UIView {
    
    // MARK: - Properties
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "")
        imageView.image = image
        return imageView
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let addFavoriteButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let cardsCollection: UICollectionView = {
        let collection = UICollectionView()
        return collection
    }()
    
    // MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
}

extension CardDetailsView: ViewCode {
    // MARK: - ViewCode
    
       func buildViewHierarchy() {
           addSubview(backgroundImageView)
           addSubview(cardsCollection)
           addSubview(closeButton)
           addSubview(addFavoriteButton)
       }
       
       func setupContraints() {
           
       }
       
       func setupAdditionalConfiguration() {
           
       }
}
