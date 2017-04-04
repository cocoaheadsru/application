//
//  UIViewController+Alert.swift
//  CHMeetupApp
//
//  Created by Kirill Averyanov on 04/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

extension UIViewController {
  func showMessageAlert(title: String?, message: String?,
                        buttonTitle: String? = "OK".localized, action: (() -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: buttonTitle, style: .default) { _ in
      if let action = action { action() }
    })
    self.present(alert, animated: true, completion: nil)
  }

  func showConfirmationAlert(title: String?, message: String?,
                             buttonFirstTitle: String? = "OK".localized,
                             buttonSecondTitle: String? = "Cancel".localized,
                             firstAction: (() -> Void)? = nil, secondAction: (() -> Void)? = nil) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: buttonFirstTitle, style: .default) { _ in
      if let action = firstAction { action() }
    })
    alert.addAction(UIAlertAction(title: buttonSecondTitle, style: .default) { _ in
      if let action = secondAction { action() }
    })
    self.present(alert, animated: true, completion: nil)
  }
}
