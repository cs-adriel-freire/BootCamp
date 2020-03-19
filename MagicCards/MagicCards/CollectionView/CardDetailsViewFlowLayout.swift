//
//  CardDetailsViewFlowLayout.swift
//  MagicCards
//
//  Created by lucca.f.ferreira on 18/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

final class CardDetailsViewFlowLayout: UICollectionViewFlowLayout {
    
    // MARK: - Variables
    
    let cellSize: CGSize
    let minimumMargin: CGFloat

    var collectionFrame: CGRect {
        didSet {
            self.invalidateLayout()
        }
    }

    // MARK: - Methods
    
    // MARK: Initializers
    
    required init(cellSize: CGSize = CGSize(width: 190.0, height: 264.0),
                  minimumMargin: CGFloat = 16.0,
                  scrollDirection: UICollectionView.ScrollDirection = .horizontal) {
        self.cellSize = cellSize
        self.minimumMargin = minimumMargin
        self.collectionFrame = .zero
        super.init()
        self.scrollDirection = scrollDirection
        self.itemSize = cellSize
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Functions
    
    override func invalidateLayout() {
        super.invalidateLayout()
        self.setLayout()
    }
    
    private func setLayout() {
        let margin = ((self.collectionView?.frame.width ?? 0) - self.cellSize.width) / 2
        self.minimumInteritemSpacing = 0
        self.minimumLineSpacing = minimumMargin
        self.sectionInset = UIEdgeInsets(top: 0.0, left: margin, bottom: 0.0, right: margin)
    }
    
}
