//
//  CardDetailsView.swift
//  MagicCards
//
//  Created by Adriel de Arruda Moura Freire on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit
import SnapKit
final class CardDetailsView: UIView {
    
    // MARK: - Properties
    public weak var delegate: CardDetailsViewDelegate?
    var collectionDataSource: CardDetailsCollectionDataSource
    
    public var viewModel: CardDetailsViewModel {
        didSet {
            collectionDataSource.cards = viewModel.cards
            cardsCollection.reloadData()
        }
    }
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "backgroundImage")
        imageView.image = image
        return imageView
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "closeIcon"), for: .normal)
        
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var addFavoriteButton: UIButton = {
        let button = UIButton()
        button.setTitle("add card to favorites", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 16)
        
        button.backgroundColor = .clear
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        
        button.addTarget(self, action: #selector(favoriteButtonAction), for: .touchUpInside)
        
        return button
    }()
    
    private lazy var cardsCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.delegate = self
        collection.register(CardCell.self, forCellWithReuseIdentifier: CardCell.reuseIdentifier)
        collection.backgroundColor = .clear
        
        return collection
    }()
    
    // MARK: - Initializers
    
    convenience init(viewModel: CardDetailsViewModel) {
        self.init(frame: .zero, viewModel: viewModel)
    }
    
    init(frame: CGRect, viewModel: CardDetailsViewModel) {
        self.viewModel = viewModel
        self.collectionDataSource = CardDetailsCollectionDataSource(cards: viewModel.cards)
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    @objc func closeButtonAction() {
        delegate?.didClickOnCloseButton()
    }
    
    @objc func favoriteButtonAction() {
        delegate?.didClickOnFavoriteButton()
    }
    
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
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
        }
        
        addFavoriteButton.snp.makeConstraints { (make) in
            make.height.equalTo(48)
            
            if #available(iOS 11.0, *) {
                make.bottom.equalTo(safeAreaLayoutGuide).offset(-16)
                make.leading.equalTo(safeAreaLayoutGuide).offset(16)
                make.trailing.equalTo(safeAreaLayoutGuide).offset(-16)
            } else {
                make.leading.equalToSuperview().offset(16)
                make.trailing.equalToSuperview().offset(-16)
                make.bottom.equalToSuperview().offset(-16)
            }
        }
        
        closeButton.snp.makeConstraints { (make) in
            make.width.equalTo(44)
            make.height.equalTo(44)
            
            if #available(iOS 11.0, *) {
                make.top.equalTo(safeAreaLayoutGuide)
                make.leading.equalTo(safeAreaLayoutGuide).offset(8)
            } else {
                make.leading.equalToSuperview().offset(8)
                make.top.equalToSuperview()
            }
        }
        
        cardsCollection.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.height.equalToSuperview().dividedBy(2)
            
            if #available(iOS 11.0, *) {
                make.leading.equalTo(safeAreaLayoutGuide)
                make.trailing.equalTo(safeAreaLayoutGuide)
            } else {
                make.leading.equalToSuperview()
                make.trailing.equalToSuperview()
            }
        }
    }
       
    func setupAdditionalConfiguration() {
        cardsCollection.dataSource = collectionDataSource
        addFavoriteButton.isHidden = true
    }
}
