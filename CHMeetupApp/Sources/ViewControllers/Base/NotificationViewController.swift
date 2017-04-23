//
//  NotificationViewController.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 19/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
  var completionBlock: () -> (Void) = {}
  var titleText: String?
  var descriptionText: String?
  var emjoi: String?

  @IBOutlet private var emotionLabel: UILabel! {
    didSet {
      emotionLabel.font = UIFont.appFont(.avenirNextDemiBold(size: 65))
      emotionLabel.text = emjoi
    }
  }

  @IBOutlet private var closeButton: LightButton! {
    didSet {
      closeButton.titleColor = UIColor(.darkGray)
      closeButton.borderColor = UIColor(.darkGray)
    }
  }

  @IBOutlet private var titleLabel: UILabel! {
    didSet {
      titleLabel.text = titleText
      titleLabel.textColor = UIColor(.darkGray)
    }
  }

  @IBOutlet private var textLabel: UILabel! {
    didSet {
      textLabel.text = descriptionText
      textLabel.textColor = UIColor(.darkGray)
    }
  }

  @IBAction private func close() {
    dismiss(animated: true, completion: nil)
    completionBlock()
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = UIColor(.lightGray)
  }
}
