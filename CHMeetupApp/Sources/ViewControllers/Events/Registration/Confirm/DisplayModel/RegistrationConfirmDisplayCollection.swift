//
//  RegistrationConfirmDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 23.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

//protocol RegistrationConfirmDisplayCollectionDelegate: class {
//  func RegistrationConfirmDisplayRequestTo(selectItemsAt selectionIndexPaths: [IndexPath],
//                                           deselectItemsAt deselectIndexPaths: [IndexPath])
//  func RegistrationConfirmDisplayRequestCell(at indexPath: IndexPath) -> UITableViewCell?
//  func RegistrationConfirmDisplayRequestTouchGeuster(enable: Bool)
//}

final class RegistrationConfirmDisplayCollection: NSObject, DisplayCollection, DisplayCollectionAction {

  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [ActionTableViewCellModel.self]
  }

//  weak var delegate: RegistrationConfirmDisplayCollectionDelegate?

  var numberOfSections: Int {
    return 1
  }

  func numberOfRows(in section: Int) -> Int {
    return 2
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    return ActionTableViewCellModel(action: ActionPlainObject(text: "Добавить"))
  }

  func headerHeight(for section: Int) -> CGFloat {
    return 300
  }

  func didSelect(indexPath: IndexPath) {

  }

}

extension RegistrationConfirmDisplayCollection: UITextFieldDelegate {
//  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//    textField.resignFirstResponder()
//    return true
//  }
//  
//  func textFieldDidBeginEditing(_ textField: UITextField) {
//    delegate?.formDisplayRequestTouchGeuster(enable: true)
//  }
//  
//  func textFieldDidEndEditing(_ textField: UITextField) {
//    delegate?.formDisplayRequestTouchGeuster(enable: false)
//  }
}
