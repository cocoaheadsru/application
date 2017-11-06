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
    return String(self[self.index(startIndex, offsetBy: index)...])
  }

  func substring(with range: Range<Int>) -> String {
    let startIndex = index(self.startIndex, offsetBy: range.lowerBound)
    let endIndex = index(self.startIndex, offsetBy: range.upperBound)
    return String(self[startIndex..<endIndex])
  }
}
