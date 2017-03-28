//
//  MainViewDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 24/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct MainViewDisplayCollection: DisplayCollection, DisplayCollectionAction {
  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [EventPreviewTableViewCellModel.self, ActionTableViewCellModel.self]
  }

  enum `Type` {
    case events
    case actionButtons
  }

  var sections: [Type] = [.events, .actionButtons]

  var actionPlainObjects: [ActionPlainObject] = []

  var successfulRequestAction: (() -> Void)?

  mutating func configureActionCellsSection(on viewController: UIViewController) {

    let actionCell = ActionCellConfigurationController()

    let remindersPermissionCell = actionCell.checkAccess(on: viewController,
                                                             for: .reminders,
                                                             with: successfulRequestAction)
    let calendarPermissionCell = actionCell.checkAccess(on: viewController,
                                                        for: .calendar,
                                                        with: successfulRequestAction)

    if let remindersCell = remindersPermissionCell {
      actionPlainObjects.append(remindersCell)
    }
    if let calendarCell = calendarPermissionCell {
      actionPlainObjects.append(calendarCell)
    }

    // FIXME: Setup with real case
    actionPlainObjects.append(ActionPlainObject(text: "Example", imageName: nil, action: {
      viewController.navigationController?.pushViewController(ViewControllersFactory.eventPreviewViewController,
                                                              animated: true)
    }))
  }

  let modelCollection: DataModelCollection<EventEntity> = {
    let predicate = NSPredicate(format: "endDate > %@", NSDate())
    let modelCollection = DataModelCollection(type: EventEntity.self).filtered(predicate)
    return modelCollection
  }()

  var numberOfSections: Int {
    return sections.count
  }

  func numberOfRows(in section: Int) -> Int {
    switch sections[section] {
    case .events:
      return modelCollection.count
    case .actionButtons:
      return actionPlainObjects.count
    }
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    switch sections[indexPath.section] {
    case .events:
      return EventPreviewTableViewCellModel(event: modelCollection[indexPath.row], index: indexPath.row)
    case .actionButtons:
      return ActionTableViewCellModel(action: actionPlainObjects[indexPath.row])
    }
  }

  func didSelect(indexPath: IndexPath) {
    switch sections[indexPath.section] {
    case .events:
      break
    case .actionButtons:
      actionPlainObjects[indexPath.row].action?()
    }
  }
}
