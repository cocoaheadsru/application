//
//  RegistrationConfirmDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 23.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
final class RegistrationConfirmDisplayCollection: NSObject, DisplayCollection, DisplayCollectionAction {
  private let regConfirmHeaderTableViewCellHeight: CGFloat = 300.0

  enum `Type` {
    case header
    case actionButtons
  }

  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [RegConfirmHeaderTableViewCellModel.self, ActionTableViewCellModel.self]
  }

  private var sections: [Type] = [.header, .actionButtons]
  private var actionPlainObjects: [ActionPlainObject] = []
  private var indexPath: IndexPath?

  func configureActionCellsSection(on viewController: UIViewController,
                                   with tableView: UITableView) {
    let actionCell = ActionCellConfigurationController()

    let action = {
      guard let index = self.indexPath else {
        return
      }
      self.actionPlainObjects.remove(at: index.row)
      tableView.deleteRows(at: [index], with: .left)
    }

    let notificationPermissionCell = actionCell.checkAccess(
      on: viewController,
      for: .notifications,
      with: {
        action()
    })

    if let notificationCell = notificationPermissionCell {
      actionPlainObjects.append(notificationCell)
    }
  }

  var numberOfSections: Int {
    return sections.count
  }

  func height(for indexPath: IndexPath) -> CGFloat {
    switch sections[indexPath.section] {
    case .header:
      return regConfirmHeaderTableViewCellHeight
    case .actionButtons:
      return UITableViewAutomaticDimension
    }
  }

  func numberOfRows(in section: Int) -> Int {
    switch sections[section] {
    case .header:
      return 1 // Only one header cell
    case .actionButtons:
      return actionPlainObjects.count
    }
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    let type = sections[indexPath.section]
    switch type {
    case .header:
      return RegConfirmHeaderTableViewCellModel()
    case .actionButtons:
      return ActionTableViewCellModel(action: actionPlainObjects[indexPath.row])
    }
  }

  func didSelect(indexPath: IndexPath) {
    switch sections[indexPath.section] {
    case .header:
      // Do nothing
      break
    case .actionButtons:
      self.indexPath = indexPath
      actionPlainObjects[indexPath.row].action?()
    }
  }
}
