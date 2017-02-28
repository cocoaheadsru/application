//
//  CHTextView.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 28.02.17.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

class CHTextView: UITextView {
  var placeholderTextView: UITextView!

  var placeholder: String? {
    set {
      placeholderTextView.text = newValue
    }
    get {
      return placeholderTextView.text
    }
  }

  required init(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)!
    commonInit()
  }

  convenience init(frame: CGRect) {
    self.init(frame: frame)
    commonInit()
  }

  private func commonInit() {
    delegate = self

    placeholderTextView = UITextView(frame: self.bounds)
    placeholderTextView.backgroundColor = UIColor.clear
    placeholderTextView.font = self.font
    placeholderTextView.textColor = self.textColor
    placeholderTextView.isUserInteractionEnabled = false
    placeholderTextView.alpha = 0.3
    placeholderTextView.isEditable = false
    self.addSubview(placeholderTextView)
    addConstraintForPlaceholder()
  }

  private func addConstraintForPlaceholder() {
// FIXME: - add constraints for placeholder in textView
  }
}

extension CHTextView: UITextViewDelegate {
  func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
    changeTheVisibilityOf(view: placeholderTextView, isHide: true)
    return true
  }

  func textViewDidEndEditing(_ textView: UITextView) {
    if self.text == nil || self.text == "" {
      changeTheVisibilityOf(view: placeholderTextView, isHide: false)
    }
  }

  private func changeTheVisibilityOf(view: UIView, isHide: Bool) {
    UIView.animate(withDuration: 0.3, animations: {
      view.alpha = isHide ? 0.0 : 0.3
    }) { (_) in
      view.isHidden = isHide
    }
  }
}
