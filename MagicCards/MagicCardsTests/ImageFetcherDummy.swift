//
//  ImageFetcherDummy.swift
//  MagicCardsTests
//
//  Created by c.cruz.agra.lopes on 26/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

@testable import MagicCards

final class ImageFetcherDummy: ImageFetcher {

    func fetchImage(for imageView: UIImageView, withUrl url: URL?, placeholder: UIImage? = nil, completion: @escaping (Error?) -> Void) -> OperationTask? {
        return nil
    }
}
