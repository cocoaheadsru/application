//
//  NotificationViewController.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 19/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class NotificationViewController: UIViewController {
  var titleText: String?
  var descriptionText: String?
  var emoji: String?

  @IBOutlet var emotionLabel: UILabel! {
    didSet {
      emotionLabel.font = UIFont.appFont(.avenirNextDemiBold(size: 65))
      emotionLabel.text = emoji
    }
  }

  @IBOutlet var closeButton: LightButton! {
    didSet {
      closeButton.titleColor = UIColor(.darkGray)
      closeButton.borderColor = UIColor(.darkGray)
    }
  }

  @IBOutlet var titleLabel: UILabel! {
    didSet {
      titleLabel.text = titleText
      titleLabel.textColor = UIColor(.darkGray)
    }
  }

  @IBOutlet var textLabel: UILabel! {
    didSet {
      textLabel.text = descriptionText
      textLabel.textColor = UIColor(.darkGray)
    }
  }

  var completionBlock: () -> (Void) = {}

  override func viewDidLoad() {
    super.viewDidLoad()
    self.view.backgroundColor = UIColor(.lightGray)
  }

  @IBAction func close() {
    self.dismiss(animated: true, completion: nil)
    completionBlock()
  }
}
