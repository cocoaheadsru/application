//
//  MainViewDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 24/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

class MainViewDisplayCollection: DisplayCollection, DisplayCollectionAction {
  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [EventPreviewTableViewCellModel.self, ActionTableViewCellModel.self]
  }

  private enum `Type` {
    case events
    case actionButtons
  }

  weak var delegate: DisplayCollectionWithTableViewDelegate?

  private var sections: [Type] = [.events, .actionButtons]
  private var actionPlainObjects: [ActionPlainObject] = []

  private var indexPath: IndexPath?

  let groupImageLoader = GroupImageLoader.standard

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

    let notificationPermissionCell = actionCell.checkAccess(on: viewController,
                                                            for: .notifications,
                                                            with: {
                                                              action()
    })

    if let notificationCell = notificationPermissionCell {
      actionPlainObjects.append(notificationCell)
    }
  }

  var modelCollection: TemplateModelCollection<EventEntity> = {
    let predicate = NSPredicate(format: "endDate > %@", NSDate())
    var dataCollection = DataModelCollection(type: EventEntity.self).filtered(predicate)
    dataCollection = dataCollection.sorted(byKeyPath: #keyPath(EventEntity.endDate), ascending: false)
    return TemplateModelCollection(dataCollection: dataCollection)
  }()

  init() {
    modelCollection.delegate = self
  }

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
      return EventPreviewTableViewCellModel(entity: modelCollection[indexPath.row],
                                            index: indexPath.row,
                                            delegate: self,
                                            groupImageLoader: groupImageLoader)
    case .actionButtons:
      return ActionTableViewCellModel(action: actionPlainObjects[indexPath.row])
    }
  }

  func didSelect(indexPath: IndexPath) {
    switch sections[indexPath.section] {
    case .events:
      if modelCollection[indexPath.row].isTemplate {
        break
      }
      let eventPreview = Storyboards.EventPreview.instantiateEventPreviewViewController()
      eventPreview.selectedEventId = modelCollection[indexPath.row].id
      delegate?.push(viewController: eventPreview)
    case .actionButtons:
      self.indexPath = indexPath
      actionPlainObjects[indexPath.row].action?()
    }
  }
}

extension MainViewDisplayCollection: TemplateModelCollectionDelegate {
  func templateModelCollectionDidUpdateData() {
    delegate?.updateUI()
  }
}

extension MainViewDisplayCollection: EventPreviewTableViewCellDelegate {
  func eventCellAcceptButtonPressed(_ eventCell: EventPreviewTableViewCell) {
    guard let indexPath = delegate?.getIndexPath(from: eventCell) else {
      assertionFailure("IndexPath is unknown")
      return
    }
    let viewController = ViewControllersFactory.eventRegistrationOrAuthViewController(
      eventId: modelCollection[indexPath.row].id
    )
    delegate?.push(viewController: viewController)
  }
}
