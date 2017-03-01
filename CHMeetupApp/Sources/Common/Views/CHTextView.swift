//
//  CHTextView.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 28.02.17.
//  Copyright © 2017 CocoaHeads Comunity. All rights reserved.
//

import UIKit

class CHTextView: UITextView {
  var placeholderTextView: UITextView! {
    didSet {
      placeholderTextView.backgroundColor = UIColor.clear
      placeholderTextView.font = self.font
      placeholderTextView.textColor = self.textColor
      placeholderTextView.isUserInteractionEnabled = false
      placeholderTextView.alpha = 0.3
      placeholderTextView.isEditable = false
      placeholderTextView.isSelectable = false
    }
  }

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
    placeholderTextView = UITextView(frame: self.bounds)
    addSubview(placeholderTextView)
    setupConstraints()
    setupNotifications()
  }

  private func setupNotifications() {
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(CHTextView.textViewDidBeginEditing),
                                           name: NSNotification.Name.UITextViewTextDidBeginEditing,
                                           object: nil)
    NotificationCenter.default.addObserver(self,
                                           selector: #selector(CHTextView.textViewDidEndEditing),
                                           name: NSNotification.Name.UITextViewTextDidEndEditing,
                                           object: nil)
  }

  @objc private func textViewDidBeginEditing() {
    changeTheVisibilityOf(view: placeholderTextView, isHide: true)
  }

  @objc private func textViewDidEndEditing() {
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

  private func setupConstraints() {
    placeholderTextView.translatesAutoresizingMaskIntoConstraints = false
    placeholderTextView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
    placeholderTextView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
    placeholderTextView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
    placeholderTextView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
  }
}
