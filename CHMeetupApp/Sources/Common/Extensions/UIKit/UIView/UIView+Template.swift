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
    if let cell = self as? UITableViewCell {
      cell.alpha = 0.0
      UIView.animate(withDuration: 0.2, animations: {
        cell.alpha = 1.0
      })
    }

    if let templateView = self as? TempalateView {
      templateView.isTemplate = template
    }

    for view in subviews {
      view.apply(template: template)
    }
  }
}
