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
    let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
    return profileStoryboard.instantiateViewController(withIdentifier: "ProfileCreateViewController")
  }

  static var profileViewController: UIViewController {
    // FIXME: - use https://github.com/krzyzanowskim/Natalie
    let profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
    return profileStoryboard.instantiateViewController(withIdentifier: "ProfileViewController")
  }

  static var eventPreviewViewController: UIViewController {
    // FIXME: - use https://github.com/krzyzanowskim/Natalie
    let eventPreview = UIStoryboard(name: "Profile", bundle: nil)
    return eventPreview.instantiateViewController(withIdentifier: "EventPreviewViewController")
  }
}
