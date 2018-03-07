//
//  UIFont+AppFonts.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 08/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit.UIFont

extension UIFont {
  enum FontType {
    case avenirNextDemiBold(size: CGFloat)
    case avenirNextMedium(size: CGFloat)
    case systemFont(size: CGFloat)
    case systemMediumFont(size: CGFloat)
  }

  static func appFont(_ fontType: FontType) -> UIFont {
    switch fontType {
    case let .avenirNextDemiBold(size):
      return UIFont(name: "AvenirNext-DemiBold", size: size) ?? UIFont.systemFont(ofSize: size)
    case let .avenirNextMedium(size):
      return UIFont(name: "AvenirNext-Medium", size: size) ?? UIFont.systemFont(ofSize: size)
    case let .systemFont(size):
      return UIFont.systemFont(ofSize: size)
    case let .systemMediumFont(size):
      return UIFont.systemFont(ofSize: size, weight: UIFont.Weight.medium)
    }
  }
}
