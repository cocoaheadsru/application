//
//  UIImageView+Setup.swift
//  CHMeetupApp
//
//  Created by Егор Петров on 05/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit.UIImageView

extension UIImageView {
  func setup() {
    contentMode = .scaleAspectFill
    clipsToBounds = true
    layer.cornerRadius = frame.height/2
  }
}
