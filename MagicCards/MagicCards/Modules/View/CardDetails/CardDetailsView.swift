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
}

extension CardDetailsView: ViewCode {
    // MARK: - ViewCode
    
    func buildViewHierarchy() {
        addSubview(backgroundImageView)
        addSubview(cardsCollection)
        addSubview(closeButton)
    }
    
    func setupContraints() {
        backgroundImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
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
    }
}
