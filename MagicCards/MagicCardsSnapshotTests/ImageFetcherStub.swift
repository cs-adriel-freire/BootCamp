//
//  ImageFetcherStub.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 26/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

@testable import MagicCards

final class ImageFetcherStub: ImageFetcher {

    var shouldReturnError: Bool = false

    func fetchImage(for imageView: UIImageView, withUrl url: URL?, placeholder: UIImage? = nil, completion: @escaping (Error?) -> Void) -> OperationTask? {
        if url == nil {
            completion(ImageFetcherFakeError.noURL)
        } else if self.shouldReturnError {
            completion(ImageFetcherFakeError.forcedError)
        } else {
            imageView.image = UIImage(named: "cardForTest")
            completion(nil)
        }

        return nil
    }
}

enum ImageFetcherFakeError: Error {
    case noURL
    case forcedError
}
