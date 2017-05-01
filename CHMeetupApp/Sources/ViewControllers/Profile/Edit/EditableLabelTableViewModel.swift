//
//  EditableLabelTableViewModel.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 02/05/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct EditableLabelTableViewModel {
  let title: String
  let description: String
  let placeholder: String
  weak var textFieldDelegate: UITextFieldDelegate?
  let valueChanged: ((String) -> Void)
}

extension EditableLabelTableViewModel: CellViewModelType {
  func setup(on cell: EditableLabelTableViewCell) {
    cell.titleLabel.text = title
    cell.descriptionTextField.text = description
    cell.descriptionTextField.placeholder = placeholder
    cell.descriptionTextField.delegate = textFieldDelegate
    cell.valueChanged = valueChanged
  }
}
