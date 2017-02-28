//
//  ProfileCreateViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 22/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit
import SafariServices

class ProfileCreateViewController: UIViewController, ProfileHierarhyViewControllerType {

  var safariViewController: SFSafariViewController?

  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(loggedIn(_:)),
                                           name: .CloseSafariViewControllerNotification,
                                           object: nil)
  }

  @IBAction func vkLoginButtonAction(_ sender: UIButton) {
    if !LoginType.vk.mayExists {
      let url = LoginType.vk.urlAuth
      showSafariViewController(url: url)
    } else {
      let url = LoginType.vk.schemeAuth
      if let url = url {
        UIApplication.shared.open(url, options: [:])
      }
    }
  }

  @IBAction func fbLoginButtonAction(_ sender: Any) {
    let url = LoginType.fb.urlAuth
    showSafariViewController(url: url)
  }
}

// MARK: - Login actions
extension ProfileCreateViewController {
  func loggedIn(_ notification: Notification? = nil) {
    // get the url form the auth callback
//    let url = (notification!.object as? URL)!
    // get the code (token) from the URL
//    print(url)
    if let safariViewController = safariViewController {
      if safariViewController.isViewLoaded {
        safariViewController.dismiss(animated: true, completion: nil)
        LoginProcessViewController.isLogin = true
        profileNavigationController?.updateRootViewController()
      }
    }
  }
}

// MARK: - Working with safariViewController
extension ProfileCreateViewController {
  func showSafariViewController(url: URL) {
    safariViewController = SFSafariViewController(url: url, entersReaderIfAvailable: true)
    self.present(safariViewController!, animated: true, completion: nil)
  }
}
