//
//  ViewControllersFactory.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct ViewControllersFactory {
  static var authViewController: UIViewController {
    return Storyboards.Profile.instantiateAuthViewController()
  }

  static var profileViewController: UIViewController {
    return Storyboards.Profile.instantiateProfileViewController()
  }

  static var eventPreviewViewController: UIViewController {
    return Storyboards.EventPreview.instantiateEventPreviewViewController()
  }
}
