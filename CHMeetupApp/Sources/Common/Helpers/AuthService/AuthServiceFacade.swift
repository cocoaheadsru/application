//
//  AuthServiceFacade.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import SafariServices

private let loginName = "UD.key.isLogin"

class AuthServiceFacade {
  fileprivate var safari: SFSafariViewController?
  fileprivate var currentViewController: UIViewController?
  fileprivate var loginCompletion: ((UserPlainObject?, Error?) -> Void)?

  enum AuthResourceType: String {
    case vk
    case fb
    case tw

    var resource: SocialResource {
      switch self {
      case .vk:
        return VKResource()
      case .fb:
        return FBResource()
      default:
        return VKResource()
      }
    }

  }

  init() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(AuthServiceFacade.loggedIn(_:)),
                                           name: .CloseSafariViewControllerNotification,
                                           object: nil)
  }

  func login(with service: AuthResourceType,
             from view: UIViewController,
             completion: @escaping (UserPlainObject?, Error?) -> Void) {
    loginCompletion = completion
    currentViewController = view

    let isLogged = LoginProcessController.isLogin
    if isLogged {
      completion(nil, nil)
    } else {
      guard let authURL = service.resource.authURL else {
        print("Auth url error")
        return
      }

      if service.resource.appExists {
        UIApplication.shared.open(authURL, options: [:])
      } else {
        showSafari(url: authURL)
      }

    }
  }

  @objc func loggedIn(_ notification: Notification? = nil) {
    hideSafari()

    guard
      let notification = notification,
      let url = notification.object as? URL
    else { return }

    let parameters = url.parameters
    if let _ = parameters?["access_token"], let loginCompletion = loginCompletion {
      loginCompletion(nil, nil)
    }
  }

  /*
   *
   * Present safari view controller to current view controller
   * Kirill Averyanov
   *
   */

  fileprivate func showSafari(url: URL) {
    safari = SFSafariViewController(url: url, entersReaderIfAvailable: true)
    currentViewController?.present(safari!, animated: true, completion: nil)
  }

  fileprivate func hideSafari() {
    if let safari = safari, safari.isViewLoaded {
      safari.dismiss(animated: true, completion: nil)
    }
  }

}

extension Notification.Name {
  // swiftlint:disable:next line_length
  static let CloseSafariViewControllerNotification: Notification.Name = Notification.Name(rawValue: "CloseSafariViewControllerNotification")
}
