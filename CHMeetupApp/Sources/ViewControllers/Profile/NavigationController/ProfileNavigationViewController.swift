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
  func pushEditProfileTo(_ navigationController: UINavigationController?)
  func logout()
}

class ProfileNavigationViewController: NavigationViewController, ProfileNavigationControllerType {

  var previousState: Bool?

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    updateBeaconTransmitterStatus()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
  }

  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    updateRootViewController()
  }

  func pushEditProfileTo(_ navigationController: UINavigationController? = nil) {
    guard let user = UserPreferencesEntity.value.currentUser else {
      return
    }

    let rootController = navigationController ?? self

    if !user.canContinue {
      let editViewController = Storyboards.Profile.instantiateProfileEditViewController()
      editViewController.canSkip = user.canContinue
      rootController.pushViewController(editViewController, animated: true)
    }

  }

  func updateRootViewController() {
    if LoginProcessController.isLogin == previousState {
      return
    }
    previousState = LoginProcessController.isLogin

    if LoginProcessController.isLogin {
      viewControllers = [ViewControllersFactory.profileViewController]
    } else {
      viewControllers = [ViewControllersFactory.authViewController]
    }
    updateBeaconTransmitterStatus()
  }

  func logout() {
    LoginProcessController.logout()
    updateRootViewController()
  }

  override func az_tabBarItemContentView() -> AZTabBarItemView {
    return TabBarItemView.create(with: .profile)
  }

  func updateBeaconTransmitterStatus() {
    //async for realm initialization
    DispatchQueue.main.async {
      BeaconTransmitter.setUser(isAuthorized: LoginProcessController.isLogin)
    }
  }
}
