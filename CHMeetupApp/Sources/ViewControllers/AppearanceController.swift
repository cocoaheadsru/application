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
    setupPlateCell()
    setupShadowView()
  }

  private static func setupNavigationBar() {
    let titleTextAttributes = [NSFontAttributeName: UIFont.appFont(.gothamProMedium(size: 13)),
                               NSForegroundColorAttributeName: UIColor(.darkGray),
                               NSKernAttributeName: 1.5] as [String : Any]
    UINavigationBar.appearance().titleTextAttributes = titleTextAttributes

  }

  private static func setupPlateCell() {
    PlateTableViewCell.appearance().plateAppearance =
      PlateTableViewCellAppearance(cornerRadius: 8,
                                   horizontalMarginValue: 12,
                                   verticalMarginValues: 4,
                                   backgroundColor: UIColor(.white),
                                   selectedBackgroundColor: UIColor(.lightGray))
  }

  private static func setupShadowView() {
    ShadowView.appearance().shadowViewAppearance =
      ShadowViewAppearance(shadowOpacity: 0.14,
                           shadowColor: UIColor(.black),
                           shadowRadius: 2)
  }
}
