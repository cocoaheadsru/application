//
//  AuthViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 22/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import SafariServices

class AuthViewController: UIViewController, ProfileHierarhyViewControllerType {
  let auth = AuthServiceFacade()
  var withRegistrationEventId: Int?

  @IBOutlet var authButtons: [UIButton]! {
    didSet {
      for button in authButtons {
        button.layer.cornerRadius = Constants.SystemSizes.cornerRadius
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.appFont(.avenirNextDemiBold(size: 16))
      }
    }
  }

  @IBOutlet var infoLabel: UILabel! {
    didSet {
      infoLabel.font = UIFont.appFont(.systemFont(size: 15))
    }
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Авторизация".localized
    // FIXME: delete it when implement twitter auth
    authButtons[2].isHidden = true
  }

  @IBAction func loginAction(_ sender: UIButton) {
    guard let buttonId = sender.restorationIdentifier,
      let authResourceType = AuthServiceFacade.AuthResourceType(rawValue: buttonId)
      else {
        assertionFailure("Set button restoration Identifier")
        return
    }

    auth.login(with: authResourceType, from: self) { [weak self] (user, error) in
      guard let user = user, error == nil else {
        self?.showMessageAlert(title: "Ошибка".localized, message: "Не удалось авторизоваться".localized)
        return
      }
      LoginProcessController.setCurrentUser(user)

      self?.completed()
    }
  }

  private func completed() {
    
    profileNavigationController?.updateRootViewController()

    if let eventId = withRegistrationEventId {
      navigationController?.popViewController(animated: true)

      let viewController = Storyboards.EventPreview.instantiateRegistrationPreviewViewController()
      viewController.selectedEventId = eventId
      push(viewController: viewController)
    }
  }
}
