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

  static func eventRegistrationOrAuthViewController(eventId: Int) -> UIViewController {
    if LoginProcessController.isLogin {
      let eventPreviewViewController = Storyboards.EventPreview.instantiateRegistrationPreviewViewController()
      eventPreviewViewController.selectedEventId = eventId
      return eventPreviewViewController
    } else {
      let authViewController = Storyboards.Profile.instantiateAuthViewController()
      authViewController.withRegistrationEventId = eventId
      return authViewController
    }
  }
}
