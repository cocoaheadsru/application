//
//  ProfileViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 22/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, ProfileHierarhyViewControllerType {

  override func viewDidLoad() {
    super.viewDidLoad()

    // Do any additional setup after loading the view.
  }

  @IBAction func logutBarButtonAction(_ sender: UIBarButtonItem) {
    LoginProcessViewController.isLogin = false
    profileNavigationController?.updateRootViewController()
  }

}
