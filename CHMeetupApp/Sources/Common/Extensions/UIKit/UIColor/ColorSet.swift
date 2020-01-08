//
//  ColorSet.swift
//  CHMeetupApp
//
//  Created by Ярослав Попов on 07.01.2020.
//  Copyright © 2020 CocoaHeads Community. All rights reserved.
//

import UIKit

enum ColorSet: String {
  /// Text
  case primaryText
  case secondaryText
  case tertiaryText

  /// Background
  case background
  case secondaryBackground
  case tertiaryBackground

  case separator

  /// Static
  case red
  case white
  case pink
  case gray
}

private extension ColorSet {
  var color: UIColor {
    let capitalized = self.rawValue
    let named = String(capitalized.prefix(1).capitalized + capitalized.dropFirst())
    return UIColor(named: named)!
  }
}

extension UIColor {
  static func from(colorSet: ColorSet) -> UIColor {
    return colorSet.color
  }
}
