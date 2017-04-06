//
//  UIImageView+ImageLoader.swift
//  CHMeetupApp
//
//  Created by Igor Voynov on 06.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

extension UIImageView {
  func loadImage(loader: ImageLoader,
                 imageURL url: URL,
                 placeholder: UIImage? = nil,
                 progressBlock: ImageLoader.ProgressBlock? = nil,
                 completionHandler: ImageLoader.CompletionBlock? = nil) {

    loader.load(self, imageURL: url,
                placeholder: placeholder, progressBlock: progressBlock, completionHandler: completionHandler)
  }
  func cancelLoadImage(loader: ImageLoader) {
    loader.cancel(self)
  }
}
