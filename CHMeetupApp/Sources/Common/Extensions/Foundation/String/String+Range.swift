//
//  String+Range.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 08/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

extension String {
  func substring(from index: Int) -> String {
    return substring(from: characters.index(startIndex, offsetBy: index))
  }

  func substring(with range: Range<Int>) -> String {
    let startIndex = characters.index(self.startIndex, offsetBy: range.lowerBound)
    let endIndex = characters.index(self.startIndex, offsetBy: range.upperBound)
    return substring(with: startIndex ..< endIndex)
  }
}
