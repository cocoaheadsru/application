//
//  UIViewController+KeyboardDelegate.swift
//  CHMeetupApp
//
//  Created by Michael Galperin on 23.02.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import ObjectiveC

private var associationKey = "private_storedkbDelegate"

// MARK: - keyboardDelegate
extension UIViewController {
  weak var keyboardDelegate: KeyboardHandlerDelegate? {
    get {
      if let handler = objc_getAssociatedObject(self, &associationKey) as? KeyboardHandler {
        return handler.delegate
      }
      return nil
    }
    set {
      let handler = KeyboardHandler(delegate: newValue)
      objc_setAssociatedObject(self, &associationKey, handler, .OBJC_ASSOCIATION_RETAIN)
    }
  }
}

// MARK: - UITextViewDelegate, UITextFieldDelegate

/*
 Adds close toolBar for UITextField and UITextView
 Do not forget to call `super` if overriding and set `delegate` of target edit fields from code or via Storyboard
 
 Overriding example:
 
 override func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
   // doing whatever you want
   return super.textFieldShouldBeginEditing(textField)
 }
*/
extension UIViewController: UITextViewDelegate, UITextFieldDelegate {
  public func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    changeWith(view: textView)
    if textView.inputAccessoryView == nil { // if set in overriden
      textView.inputAccessoryView = doneToolBar
    }
    return true
  }
  public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
    changeWith(view: textField)
    if textField.inputAccessoryView == nil { // if set in overriden
      textField.inputAccessoryView = doneToolBar
    }
    return true
  }
  // ----- Staff only -----
  private var doneToolBar: UIToolbar {
    let barFrame = CGRect(x: 0, y: 0, width: 0, height: 40)
    let bar = UIToolbar(frame: barFrame)
    let btnDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(_endEditing))
    let flex = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    bar.items = [flex, btnDone]
    return bar
  }
  private func changeWith(view: UIView) {
    if prevInputView == nil {
      prevInputView = view
      activeInputView = view
    } else {
      prevInputView = activeInputView
      activeInputView = view
    }
  }
  @objc private func _endEditing() {
    view.endEditing(true)
  }
}
