//
//  TextViewWithPlaceholder.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 28.02.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class TextViewWithPlaceholder: UITextView {
  func updatePlacholderViewStyle() {
    placeholderTextView.backgroundColor = UIColor.clear
    placeholderTextView.font = font
    placeholderTextView.textColor = textColor
    placeholderTextView.isUserInteractionEnabled = false
    placeholderTextView.alpha = 0.3
    placeholderTextView.isEditable = false
    placeholderTextView.isSelectable = false
  }

  var placeholderTextView: UITextView! {
    didSet {
      updatePlacholderViewStyle()
    }
  }

  var placeholder: String? {
    didSet {
      placeholderTextView.text = placeholder
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
    placeholderTextView = UITextView(frame: bounds)
    addSubview(placeholderTextView)
    setupConstraints()
    setupNotifications()
  }

  private func setupNotifications() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(TextViewWithPlaceholder.textViewDidChange),
                                           name: UITextView.textDidChangeNotification,
                                           object: nil)
  }

  @objc private func textViewDidChange() {
    let isHide = !text.isEmpty
    changeTheVisibilityOf(view: placeholderTextView, isHide: isHide)
  }

  private func changeTheVisibilityOf(view: UIView, isHide: Bool) {
    UIView.animate(withDuration: 0.2, animations: {
      view.alpha = isHide ? 0.0 : 0.3
    })
  }

  private func setupConstraints() {
    placeholderTextView.translatesAutoresizingMaskIntoConstraints = false
    placeholderTextView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
    placeholderTextView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    placeholderTextView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
    placeholderTextView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
  }
}
