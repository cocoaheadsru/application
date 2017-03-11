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
  var horizontalMarginValue: CGFloat
  var verticalMarginValues: CGFloat

  init(cornerRadius: CGFloat, horizontalMarginValue: CGFloat, verticalMarginValues: CGFloat) {
    self.cornerRadius = cornerRadius
    self.horizontalMarginValue = horizontalMarginValue
    self.verticalMarginValues = verticalMarginValues
  }
}
