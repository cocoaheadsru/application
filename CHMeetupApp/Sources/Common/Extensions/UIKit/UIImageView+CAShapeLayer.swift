//
//  UIImageView+CAShapeLayer.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 01/05/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit.UIImageView
import ObjectiveC

private var associationKey = "cashapelayer_border"

// MARK: - CAShapeLayer
extension UIImageView {
  var shapeLayerBorder: CAShapeLayer? {
    get {
      if let border = objc_getAssociatedObject(self, &associationKey) as? CAShapeLayer {
        return border
      }
      return nil
    }
    set {
      guard let border = newValue, shapeLayerBorder == nil else {
        return
      }
      objc_setAssociatedObject(self, &associationKey, border, .OBJC_ASSOCIATION_RETAIN)
      layer.addSublayer(border)
    }
  }
}
