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
    setupShadowView()
  }

  private static func setupNavigationBar() {
    let titleTextAttributes = [NSFontAttributeName: UIFont.appFont(.gothamProMedium(size: 13)),
                               NSForegroundColorAttributeName: UIColor(.lightGrey),
                               NSKernAttributeName: 1.5] as [String : Any]
    UINavigationBar.appearance().titleTextAttributes = titleTextAttributes

  }

  private static func setupPlateCell() {
    PlateTableViewCell.appearance().plateAppearance =
      PlateTableViewCellAppearance(cornerRadius: 8, marginValue: 8)
  }

  private static func setupShadowView() {
    ShadowView.appearance().shadowViewAppearance =
      ShadowViewAppearance(shadowOpacity: 0.14, shadowColor: UIColor(.black), shadowRadius: 2)
  }
}
