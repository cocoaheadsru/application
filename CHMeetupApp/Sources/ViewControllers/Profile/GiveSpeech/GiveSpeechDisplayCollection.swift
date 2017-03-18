//
//  GiveSpeechDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 18/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

class GiveSpeechDisplayCollection: DisplayCollection {
  var numberOfSections: Int {
    return 1
  }

  func numberOfRows(in section: Int) -> Int {
    return 2
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    let model = TextFieldPlateTableViewCellModel(placeholder: "Название".localized, textFieldDelegate: nil)
    return model
  }
}
