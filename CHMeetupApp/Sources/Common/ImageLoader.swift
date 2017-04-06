//
//  ImageLoader.swift
//  CHMeetupApp
//
//  Created by Igor Voynov on 06.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol ImageLoader: class {
  typealias ProgressBlock = (_ receivedSize: Int, _ totalSize: Int) -> Void
  typealias CompletionBlock = (_ image: UIImage?, _ error: Error?) -> Void

  static var standard: ImageLoader { get }
  func load(_ imageView: UIImageView,
            imageURL url: URL)

  func load(_ imageView: UIImageView,
            imageURL url: URL,
            placeholder: UIImage?,
            progressBlock: ImageLoader.ProgressBlock?,
            completionHandler: ImageLoader.CompletionBlock?)

  func cancel(_ imageView: UIImageView)

  func clearCache()
}
