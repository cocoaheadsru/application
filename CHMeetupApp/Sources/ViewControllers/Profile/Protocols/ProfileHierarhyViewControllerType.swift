//
//  ProfileHierarhyViewControllerType.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol ProfileHierarhyViewControllerType: class {
  func getViewController() -> UIViewController?
}

extension ProfileHierarhyViewControllerType where Self: UIViewController {
  var profileNavigationController: ProfileNavigationControllerType? {
    let controller = tabBarController?.viewControllers?.first(where: { $0 is ProfileNavigationControllerType })
    return controller as? ProfileNavigationControllerType
  }

  func getViewController() -> UIViewController? {
    return self
  }
}
