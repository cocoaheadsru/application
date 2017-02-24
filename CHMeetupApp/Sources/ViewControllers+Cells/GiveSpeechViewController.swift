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
  @IBOutlet weak var descriptionTextView: UITextView!

  override func viewDidLoad() {
    super.viewDidLoad()
    configurateUI()
  }

  func configurateUI() {
    descriptionTextView.layer.cornerRadius  = 5
    descriptionTextView.layer.borderWidth   = 1
    descriptionTextView.layer.borderColor   = UIColor.lightGray.cgColor
  }

  @IBAction func sendSpeechPressed(_ sender: UIBarButtonItem) {
  }

}

// MARK: - UITextFieldDelegate
extension GiveSpeechViewController: UITextFieldDelegate {
}

// MARK: - UITextViewDelegate
extension GiveSpeechViewController: UITextViewDelegate {
}
