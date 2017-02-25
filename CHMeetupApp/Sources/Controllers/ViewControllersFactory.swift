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
    return Storyboards.Profile.instantiateProfileCreateViewController()
  }

  static var profileViewController: UIViewController {
    return Storyboards.Profile.instantiateProfileViewController()
  }

  static var eventPreviewViewController: UIViewController {
    return Storyboards.EventPreview.instantiateEventPreviewViewController()
  }
}
