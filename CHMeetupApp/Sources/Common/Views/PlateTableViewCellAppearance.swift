//
//  PlateTableViewCellAppearance.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 12/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import CoreGraphics

@objc
class PlateTableViewCellAppearance: NSObject {
  var cornerRadius: CGFloat
  var marginValue: CGFloat

  init(cornerRadius: CGFloat, marginValue: CGFloat) {
    self.cornerRadius = cornerRadius
    self.marginValue = marginValue
  }
}
