//
//  UIImageView+RoundBorder.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 22/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
  func roundWithBorder(_ approximateBorderWidth: CGFloat, color: UIColor = .white) {
    let border = makeRoundBorder(approximateBorderWidth, color: color)

    removeRoundWithBorder(approximateBorderWidth, color: color)
    roundCorners()
    layer.addSublayer(border)
  }

  func removeRoundWithBorder(_ approximateBorderWidth: CGFloat, color: UIColor) {
    let border = makeRoundBorder(approximateBorderWidth, color: color)

    if let sublayers = layer.sublayers {
      sublayers.forEach({ sublayer in
        if let sublayer = sublayer as? CAShapeLayer,
          areEqualLayers(layer1: sublayer, layer2: border) {
          sublayer.removeFromSuperlayer()
        }
      })
    }
  }

  fileprivate func areEqualLayers(layer1: CAShapeLayer, layer2: CAShapeLayer) -> Bool {
    if layer1.strokeColor == layer2.strokeColor,
      layer1.fillColor == layer2.fillColor,
      layer1.lineWidth == layer2.lineWidth,
      layer1.path == layer2.path,
      layer1.frame == layer2.frame {
      return true
    }
    return false
  }

  fileprivate func makeRoundBorder(_ approximateBorderWidth: CGFloat, color: UIColor) -> CAShapeLayer {
    let border = CAShapeLayer()
    border.strokeColor = color.cgColor
    border.fillColor = UIColor.clear.cgColor
    border.frame = bounds
    border.lineWidth = (approximateBorderWidth * 2).round(0.5)
    border.path = UIBezierPath(ovalIn: border.bounds).cgPath
    return border
  }
}
