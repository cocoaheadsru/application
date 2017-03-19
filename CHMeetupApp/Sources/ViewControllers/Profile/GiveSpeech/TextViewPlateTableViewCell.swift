//
//  TextViewPlateTableViewCell.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 19/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class TextViewPlateTableViewCell: PlateTableViewCell {
  @IBOutlet var textView: TextViewWithPlaceholder! {
    didSet {
      textView.textColor = UIColor(.darkGray)
      textView.font = UIFont.appFont(.gothamPro(size: 16))
      textView.updatePlacholderViewStyle()
    }
  }
}
