//
//  BottomButton.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 19/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class BottomButton: ActionButton {
  private struct Constants {
    static var height: CGFloat = 50
    static var backgroundColor: UIColor = UIColor(.pink)
  }

  init(bindToView view: UIView) {
    super.init(frame: .zero)

    view.addSubview(self)
    self.anchor(left: view.leftAnchor, right: view.rightAnchor, bottom: view.bottomAnchor, heightConstant: 44)
    setup()
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func setup() {
    backgroundColor = UIColor(.pink)
    titleLabel?.font = UIFont.appFont(.gothamProMedium(size: 15))
    setTitleColor(UIColor(.white), for: .normal)
  }
}
