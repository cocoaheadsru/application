//
//  UIImageView+RoundBorder.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 22/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
  func roundWithWhiteBorder(_ approximateBorderWidth: CGFloat) {
    _ = makeRoundBourder(approximateBorderWidth)
  }

  func getRoundWithWhiteBorder(_ approximateBorderWidth: CGFloat) -> CAShapeLayer {
    return makeRoundBourder(approximateBorderWidth)
  }

  fileprivate func makeRoundBourder(_ approximateBorderWidth: CGFloat) -> CAShapeLayer {
    roundCorners()

    let border = CAShapeLayer()
    border.strokeColor = UIColor.white.cgColor
    border.fillColor = UIColor.clear.cgColor
    border.frame = bounds
    border.lineWidth = (approximateBorderWidth * 2).round(0.5)
    border.path = UIBezierPath(ovalIn: border.bounds).cgPath
    layer.addSublayer(border)
    return border
  }
}
