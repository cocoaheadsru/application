//
//  KingfisherImageLoader.swift
//  CHMeetupApp
//
//  Created by Igor Voynov on 06.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import Kingfisher

class KingfisherImageLoader: ImageLoader {

  static var standard: ImageLoader {
    return KingfisherImageLoader()
  }

  func load(_ imageView: UIImageView, imageURL url: URL) {
    load(imageView, imageURL: url, placeholder: nil, progressBlock: nil, completionHandler: nil)
  }

  func load(_ imageView: UIImageView,
            imageURL url: URL,
            placeholder: UIImage? = nil,
            progressBlock: ImageLoader.ProgressBlock? = nil,
            completionHandler: ImageLoader.CompletionBlock? = nil) {

    imageView.kf.indicatorType = .activity
    imageView.kf.setImage(with: url, placeholder: placeholder, options: [],
                          progressBlock: { (receivedSize, totalSize) in
      if let progressBlock = progressBlock {
        progressBlock(Int(truncatingBitPattern: receivedSize), Int(truncatingBitPattern: totalSize))
      }
    }, completionHandler: { (image, error, _, _) in
      if let completionHandler = completionHandler {
        if let image = image, error == nil {
          completionHandler(image, nil)
        } else {
          completionHandler(nil, error)
        }
      }
    })
  }

  func cancel(_ imageView: UIImageView) {
    imageView.kf.cancelDownloadTask()
  }

  func clearCache() {
    KingfisherManager.shared.cache.clearMemoryCache()
    KingfisherManager.shared.cache.clearDiskCache()
  }
}
