//
//  UIView+Template.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 23/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit.UIView

extension UIView {
  func apply(template: Bool) {
    if let templateView = self as? TempalateView {
      templateView.isTemplate = template
    }

    for view in subviews {
      view.apply(template: template)
    }
  }
}
