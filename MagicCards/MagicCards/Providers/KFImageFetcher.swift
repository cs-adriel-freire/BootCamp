//
//  KFImageFetcher.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 26/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import Kingfisher
import UIKit

final class KFImageFetcher: ImageFetcher {

    func fetchImage(for imageView: UIImageView, withUrl url: URL?, placeholder: UIImage? = nil, completion: @escaping (Error?) -> Void) -> OperationTask? {
        return imageView.kf.setImage(with: url, placeholder: placeholder) { result in
            if case let .failure(error) = result {
                completion(error)
            } else {
                completion(nil)
            }
        }
    }
}
