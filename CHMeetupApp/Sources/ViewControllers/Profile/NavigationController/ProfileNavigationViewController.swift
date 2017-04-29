//
//  ProfileNavigationViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol ProfileNavigationControllerType {
  func updateRootViewController()
}

class ProfileNavigationViewController: NavigationViewController, ProfileNavigationControllerType {

  var preveousState: Bool?

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateRootViewController()
  }

  func updateRootViewController() {
    if LoginProcessController.isLogin == preveousState {
      return
    }
    preveousState = LoginProcessController.isLogin

    if LoginProcessController.isLogin {
      viewControllers = [ViewControllersFactory.profileViewController]
    } else {
      viewControllers = [ViewControllersFactory.authViewController]
    }
  }

  override func customTabBarItemContentView() -> CustomTabBarItemView {
    return TabBarItemView.create(with: .profile)
  }
}
