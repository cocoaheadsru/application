//
//  GiveSpeechDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 18/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class GiveSpeechDisplayCollection: DisplayCollection {
  enum `Type` {
    case textField
    case textView
  }

  var sections: [Type] = [.textField,
                          .textView]

  var numberOfSections: Int {
    return sections.count
  }

  func numberOfRows(in section: Int) -> Int {
    return 1
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    switch sections[indexPath.section] {
    case .textField:
      return TextFieldPlateTableViewCellModel(placeholder: "Название".localized, textFieldDelegate: nil)
    case .textView:
      return TextViewPlateTableViewCellModel(placeholder: "О чем будет Ваша речь?".localized, textFieldDelegate: nil)
    }
  }

  func height(for indexPath: IndexPath) -> CGFloat {
    switch sections[indexPath.section] {
    case .textField:
      return 52
    case .textView:
      return 350
    }
  }

  func headerHeight(for section: Int) -> CGFloat {
    switch sections[section] {
    case .textField, .textView:
      return 40
    }
  }
}
