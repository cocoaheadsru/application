//
//  AttributedSentenceHelper.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 05.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class AttributedSentenceHelper {

  enum Preposition: String {
    case at

    var localizedValue: String {
      return self.rawValue.localized
    }

    func configureAttributedString(_ string: String) -> NSAttributedString {
      let nsString = string as NSString
      let atRange = nsString.range(of: self.localizedValue)
      let attributtedString = NSMutableAttributedString(string: string)
      attributtedString.addAttribute(NSForegroundColorAttributeName,
                                     value: UIColor(.gray),
                                     range: atRange)
      return attributtedString
    }
  }

  static func concatString(with preposition: Preposition, firstPartString: String?, secondPartString: String?)
    -> NSAttributedString {

    let firstString = firstPartString ?? ""
    let secondString = secondPartString ?? ""

    if !firstString.isEmpty && !secondString.isEmpty {
      let concatString = firstString + " " + preposition.localizedValue + " " + secondString
      return preposition.configureAttributedString(concatString)
    } else {
      let string = firstString.isEmpty ? secondString : firstString
      let attributes = [NSForegroundColorAttributeName: UIColor(.darkGray)]
      return NSAttributedString(string: string, attributes: attributes)
    }
  }

}
