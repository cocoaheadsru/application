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

  var safariVC: SFSafariViewController?

  override func viewDidLoad() {
    super.viewDidLoad()
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(loggedIn(_:)),
                                           name: .closeSafariVCNote,
                                           object: nil)
  }

  @IBAction func vkLoginButtonAction(_ sender: UIButton) {
    if !vkAppMayExists {
      let url = LoginType.vk.urlAuth
      showSafariVC(url: url)
    } else {
      let url = LoginType.vk.schemeAuth!
      UIApplication.shared.open(url, options: [:])
    }
  }

  @IBAction func fbLoginButtonAction(_ sender: Any) {
    let url = LoginType.fb.urlAuth
    showSafariVC(url: url)
  }
}

// MARK: - Login actions
extension ProfileCreateViewController {

  var vkAppMayExists: Bool {
    return UIApplication.shared.canOpenURL(LoginType.vk.schemeAuth!)
  }

  func loggedIn(_ notification: Notification? = nil) {
    // get the url form the auth callback
//    let url = (notification!.object as? URL)!
    // get the code (token) from the URL
//    print(url)
    if safariVC!.isViewLoaded {
      safariVC!.dismiss(animated: true, completion: nil)
      LoginProcessViewController.isLogin = true
      profileNavigationController?.updateRootViewController()
    }
  }
}

// MARK: - Working with safariVC
extension ProfileCreateViewController {
  func showSafariVC(url: URL) {
    safariVC = SFSafariViewController(url: url, entersReaderIfAvailable: true)
    self.present(safariVC!, animated: true, completion: nil)
  }
}
