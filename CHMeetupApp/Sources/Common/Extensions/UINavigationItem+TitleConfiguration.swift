//
//  UINavigationItem+TitleConfiguration.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

private var swizzle: Void = {
  swizzleMethods(objectClass: UINavigationItem.self,
                 originalSelector: #selector(setter: UINavigationItem.title),
                 swizzledSelector: #selector(UINavigationItem.chSetTitle(_:)))
}()

// We need this class because default title label doesn't support NSKernAttribute
extension UINavigationItem {
  open override class func initialize() {
    _ = swizzle
  }

  // for swizzle we would use prefix to avoid problems
  @objc
  fileprivate func chSetTitle(_ title: String?) {
    chSetTitle(title)

    guard let title = title else { return }

    let attributes = UINavigationBar.appearance().titleTextAttributes
    let attributedString = NSMutableAttributedString(string: title.uppercased(), attributes: attributes)

    let titleLabel = UILabel()
    titleLabel.attributedText = attributedString
    titleLabel.sizeToFit()

    titleView = titleLabel
  }
}
