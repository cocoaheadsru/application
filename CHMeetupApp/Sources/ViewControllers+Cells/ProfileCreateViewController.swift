//
//  ProfileCreateViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 22/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

class ProfileCreateViewController: UIViewController, ProfileHierarhyViewControllerType {
  
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  @IBAction func loginButtonAction(_ sender: UIButton) {
    LoginProcessViewController.isLogin = true
    profileNavigationController?.updateRootViewController()
  }
  
}
