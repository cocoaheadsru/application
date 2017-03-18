//
//  GiveSpeechViewController.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class GiveSpeechViewController: UIViewController, UITableViewDataSource {

  @IBOutlet var tableView: UITableView! {
    didSet {
      tableView.registerNib(for: TextFieldPlateTableViewCell.self)
    }
  }

  var displayCollection: GiveSpeechDisplayCollection!

  @IBOutlet weak var sendSpeechButton: UIBarButtonItem!
//  @IBOutlet weak var titleLabel: UILabel!
//  @IBOutlet weak var titleTextField: UITextField!
//  @IBOutlet weak var descriptionTextView: TextViewWithPlaceholder! {
//    didSet {
//      descriptionTextView.layer.cornerRadius  = 5
//      descriptionTextView.layer.borderWidth   = 1
//      descriptionTextView.layer.borderColor   = UIColor.lightGray.withAlphaComponent(0.3).cgColor
//      descriptionTextView.placeholder         = "placeholder"
//    }
//  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // keyboardDelegate = self
    setupGestureRecognizer()

    displayCollection = GiveSpeechDisplayCollection()

    view.backgroundColor = UIColor(.lightGray)
    title = "Geve a speech".localized
  }

  func setupGestureRecognizer() {
    let dissmisKBTouch =
      UITapGestureRecognizer(target: self,
                             action: #selector(GiveSpeechViewController.dismissKeyboard))
    view.addGestureRecognizer(dissmisKBTouch)
  }

  func sendSpeech() {
    // Do stuff here ...
  }

  @IBAction func sendSpeechButtonPressed(_ sender: UIBarButtonItem) {
    sendSpeech()
  }

  func dismissKeyboard() {
    view.endEditing(true)
  }

  func numberOfSections(in tableView: UITableView) -> Int {
    return displayCollection.numberOfSections
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return displayCollection.numberOfRows(in: section)
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let model = displayCollection.model(for: indexPath)
    let cell = tableView.dequeueReusableCell(for: indexPath, with: model)
    return cell
  }

}

//// MARK: - UITextFieldDelegate
//extension GiveSpeechViewController {
//  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    if textField == titleTextField {
//      descriptionTextView.becomeFirstResponder()
//      return false
//    }
//    return true
//  }
//}
//
//// MARK: - KeyboardHandlerDelegate
//extension GiveSpeechViewController: KeyboardHandlerDelegate {
//  func keyboardStateChanged(input: UIView?, state: KeyboardState, info: KeyboardInfo) {
//
//    var scrollViewContnetInsets = scrollView.contentInset
//    var indicatorContentInsets = scrollView.scrollIndicatorInsets
//
//    switch state {
//    case .frameChanged:
//      scrollViewContnetInsets.bottom = info.endFrame.height
//      indicatorContentInsets.bottom = info.endFrame.height
//    case .opened:
//      scrollView.isScrollEnabled = true
//      scrollViewContnetInsets.bottom = info.endFrame.height
//      indicatorContentInsets.bottom = info.endFrame.height
//    case .hidden:
//      scrollView.isScrollEnabled = false
//      scrollViewContnetInsets.bottom = 0
//      indicatorContentInsets.bottom = 0
//    }
//
//    scrollView.contentInset = scrollViewContnetInsets
//    scrollView.scrollIndicatorInsets = indicatorContentInsets
//  }
//}
