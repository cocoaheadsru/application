//
//  AppearanceController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct AppearanceController {
  static func setupAppearance() {
    setupNavigationBar()
  }

  private static func setupNavigationBar() {
    let titleTextAttributes = [NSFontAttributeName: UIFont.appFont(.gothamProMedium(size: 13)),
                               NSForegroundColorAttributeName: UIColor(.lightGrey),
                               NSKernAttributeName: 1.5] as [String : Any]
    UINavigationBar.appearance().titleTextAttributes = titleTextAttributes

  }
}
