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
    _ = makeRoundBorder(approximateBorderWidth, color: color)
  }

  func getRoundWithBorder(_ approximateBorderWidth: CGFloat, color: UIColor = .white) -> CAShapeLayer {
    return makeRoundBorder(approximateBorderWidth, color: color)
  }

  fileprivate func makeRoundBorder(_ approximateBorderWidth: CGFloat, color: UIColor) -> CAShapeLayer {
    roundCorners()

    let border = CAShapeLayer()
    border.strokeColor = color.cgColor
    border.fillColor = UIColor.clear.cgColor
    border.frame = bounds
    border.lineWidth = (approximateBorderWidth * 2).round(0.5)
    border.path = UIBezierPath(ovalIn: border.bounds).cgPath
    layer.addSublayer(border)
    return border
  }
}
