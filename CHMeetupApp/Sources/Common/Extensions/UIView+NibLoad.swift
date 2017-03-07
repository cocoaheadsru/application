//
//  UIView+NibLoad.swift
//  AZTabBarController
//
//  Created by Alex Zimin on 15/11/2016.
//  Copyright © 2016 Alexander Zimin. All rights reserved.
//

import UIKit

internal extension UIView {
  class func viewFromNib() -> Self {
    return self.viewFromNib(withOwner: nil)
  }

  class func viewFromNib(withOwner owner: Any?) -> Self {
    // FIXME: - Improve syntax
    let name = String(describing: type(of: self)).components(separatedBy: ".").first!
    // swiftlint:disable:this force_cast
    let view = UINib(nibName: name, bundle: nil).instantiate(withOwner: owner, options: nil).first!
    return cast(view)! // swiftlint:disable:previous force_cast
  }

  func loadFromNibIfEmbeddedInDifferentNib() -> Self {
    // based on: http://blog.yangmeyer.de/blog/2012/07/09/an-update-on-nested-nib-loading
    let isJustAPlaceholder = self.subviews.count == 0
    if isJustAPlaceholder {
      let theRealThing = type(of: self).viewFromNib(withOwner: nil)
      theRealThing.frame = self.frame
      self.translatesAutoresizingMaskIntoConstraints = false
      theRealThing.translatesAutoresizingMaskIntoConstraints = false
      return theRealThing
    }
    return self
  }
}

private func cast<T, U>(_ value: T) -> U? {
  return value as? U
}
