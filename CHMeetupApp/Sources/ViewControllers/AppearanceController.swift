//
//  AppearanceController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import SVProgressHUD

struct AppearanceController {
  static func setupAppearance() {
    setupNavigationBar()
    setupPlateCell()
    setupShadowView()
    setupHUD()
  }

  private static func setupNavigationBar() {
    let titleTextAttributes: [NSAttributedStringKey: Any] = [
      NSAttributedStringKey.font: UIFont.appFont(.avenirNextDemiBold(size: 14)),
      NSAttributedStringKey.foregroundColor: UIColor(.darkGray),
      NSAttributedStringKey.kern: 1.5
    ]
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

  private static func setupHUD() {
    SVProgressHUD.appearance().defaultMaskType = .black
  }
}
