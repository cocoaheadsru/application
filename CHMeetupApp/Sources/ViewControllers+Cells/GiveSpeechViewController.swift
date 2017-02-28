//
//  GiveSpeechViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

class GiveSpeechViewController: UIViewController {

  @IBOutlet weak var sendSpeechButton: UIBarButtonItem!
  @IBOutlet weak var titleLabel: UILabel!
  @IBOutlet weak var titleTextField: UITextField!
  @IBOutlet weak var descriptionTextView: CHTextView! {
    didSet {
      descriptionTextView.layer.cornerRadius  = 5
      descriptionTextView.layer.borderWidth   = 1
      descriptionTextView.layer.borderColor   = UIColor.lightGray.withAlphaComponent(0.3).cgColor
    }
  }
  @IBOutlet weak var scrollViewBottomConstraint: NSLayoutConstraint!

  override func viewDidLoad() {
    super.viewDidLoad()
    descriptionTextView.placeholder = "placehilder"
  }

  func sendSpeech() {
    // Do stuff here ...
  }

  @IBAction func sendSpeechButtonPressed(_ sender: UIBarButtonItem) {
    sendSpeech()
  }

  func textFieldShouldReturn(textField: UITextField) -> Bool {
    if textField == titleTextField {
      descriptionTextView.becomeFirstResponder()
    }
    return true
  }

}

// MARK: - UITextFieldDelegate
//extension GiveSpeechViewController {
//  func textFieldShouldReturn(textField: UITextField) -> Bool {
//    if textField == titleTextField {
//      descriptionTextView.becomeFirstResponder()
//    }
//    return true
//  }
//}

// MARK: - UITextViewDelegate
//extension GiveSpeechViewController: UITextViewDelegate {
//
//}
