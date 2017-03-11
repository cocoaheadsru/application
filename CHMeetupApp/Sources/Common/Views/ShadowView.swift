//
//  ShadowView.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

// Class with our configuration
class ShadowView: UIView {

  override init(frame: CGRect) {
    super.init(frame: frame)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setup()
  }

  private func setup() {
    layer.shadowOpacity = 0.14
    layer.shadowColor = UIColor(.black).cgColor
    layer.shadowRadius = 2
    layer.shadowOffset = CGSize.zero
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    layer.shadowPath = UIBezierPath(rect: bounds).cgPath
  }
}
