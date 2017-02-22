//
//  ViewControllersFactory.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

struct ViewControllersFactory {
  static var loginViewController: UIViewController {
    // FIXME: - use https://github.com/krzyzanowskim/Natalie
    return UIStoryboard(name: "Profile", bundle: nil).instantiateViewController(withIdentifier: "ProfileViewControllerNavigation")
  }
}
