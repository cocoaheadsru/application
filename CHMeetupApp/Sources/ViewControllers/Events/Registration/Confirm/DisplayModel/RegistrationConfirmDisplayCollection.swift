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

  var event: EventEntity?

  func configureActionCellsSection(on viewController: UIViewController,
                                   with tableView: UITableView) {
    let actionCell = ActionCellConfigurationController()

    let calendarPermissionCell = actionCell.addActionCell(
      on: viewController,
      for: .calendar,
      with: {
        self.import(event: self.event, to: .calendar, from: viewController)
    })

    let remindersPermissionCell = actionCell.addActionCell(
      on: viewController,
      for: .reminders,
      with: {
        self.import(event: self.event, to: .reminder, from: viewController)
    })

    if let calendarPermissionCell = calendarPermissionCell {
      actionPlainObjects.append(calendarPermissionCell)
    }

    if let remindersPermissionCell = remindersPermissionCell {
      actionPlainObjects.append(remindersPermissionCell)
    }
  }

  private func `import`(event: EventEntity?, to type: Importer.ImportType, from viewController: UIViewController) {
    if let event = self.event {
      Importer.import(event: event, to: type, completion: { (result) in
        switch result {
        case .success:
          break
        case .permissionError:
          viewController.showMessageAlert(title: "Нет прав доступа".localized)
        case .saveError(_):
          viewController.showMessageAlert(title: "Ошибка сохранения".localized)
        }
      })
    } else {
      assertionFailure("No event entity")
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
      return event != nil ? actionPlainObjects.count : 0
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
