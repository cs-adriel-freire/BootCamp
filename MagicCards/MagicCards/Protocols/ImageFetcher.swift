//
//  ImageFetcher.swift
//  MagicCards
//
//  Created by c.cruz.agra.lopes on 26/03/20.
//  Copyright © 2020 Concrete. All rights reserved.
//

import UIKit

protocol ImageFetcher {

    func fetchImage(for imageView: UIImageView, withUrl url: URL?, placeholder: UIImage?, completion: @escaping (Error?) -> Void) -> OperationTask?
}
