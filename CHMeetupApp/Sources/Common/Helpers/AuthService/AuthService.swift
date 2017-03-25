//
//  AuthService.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 25/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import SafariServices

class AuthService {
  fileprivate var safari: SFSafariViewController?
  fileprivate var currentViewController: UIViewController?

  enum AuthResourceType {
    case vk
    case fb
    case tw

    var resource: AuthResource {
      switch self {
      case .vk:
        return VKResource()
      default:
        return VKResource()
      }
    }

  }

  func login(with service: AuthResourceType, from view: UIViewController) {
    currentViewController = view
    service.resource.login { (token, secret, error) in
      print(token)
    }
  }

  /*
   *
   * Present safari view controller to current view controller
   * @author Kirill
   *
   */
  func showSafariViewController(url: URL) {
    safari = SFSafariViewController(url: url, entersReaderIfAvailable: true)
    currentViewController?.present(safari!, animated: true, completion: nil)
  }

  func hideSafariViewController() {
    if let safari = safari {
      if safari.isViewLoaded {
        safari.dismiss(animated: true, completion: nil)
      }
    }
  }

}
