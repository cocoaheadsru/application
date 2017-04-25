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
    for view in subviews {
      if let templateView = view as? TempalteView {
        templateView.isTemplate = template
      }
      view.apply(template: template)
    }
  }
}
