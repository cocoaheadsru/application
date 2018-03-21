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
    return [EventPreviewTableViewCellModel.self, ActionTableViewCellModel.self, ActionDetailIconCellModel.self]
  }

  fileprivate enum `Type` {
    case events
    case actionButtons
    case findNearestButtons
    case collectionIsEmpty
  }

  weak var delegate: DisplayCollectionWithTableViewDelegate?

  private let switchActionController = SwitchActionCellController()

  fileprivate var sections: [Type] = [.events, .actionButtons, .findNearestButtons, .collectionIsEmpty]
  private var actionPlainObjects: [ActionPlainObject] = []
  private var findNearestPlainObjects: [ActionPlainObject] = []

  let groupImageLoader = GroupImageLoader.standard

  func updateActionCellsSection(on viewController: UIViewController,
                                with tableView: UITableView) {
    actionPlainObjects = []
    findNearestPlainObjects = []

    let findNearestObject = ActionPlainObject(
      text: "Люди вокруг".localized,
      imageName: "air-drop",
      isColorized: !BeaconTransmitter.isTurnedOn()) { [weak delegate] in
      let findNearest = Storyboards.Profile.instantiateFindNearestViewController()
      delegate?.push(viewController: findNearest)
    }

    findNearestPlainObjects.append(findNearestObject)
  }

  var modelCollection: TemplateModelCollection<EventEntity> = {
    let predicate = NSPredicate(format: "endDate > %@", NSDate())
    var dataCollection = DataModelCollection(type: EventEntity.self).filtered(predicate)
    dataCollection = dataCollection.sorted(byKeyPath: #keyPath(EventEntity.priority), ascending: false)
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
    case .findNearestButtons:
      guard findNearestPlainObjects.count > 0,
        needShowSwitchCell() else { return 0 }
      return findNearestPlainObjects.count
    case .collectionIsEmpty:
      if modelCollection.count == 0 && actionPlainObjects.count == 0 {
        return 1
      }
      return 0
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
    case .findNearestButtons:
      return ActionDetailIconCellModel(action: findNearestPlainObjects[indexPath.row])
    case .collectionIsEmpty:
      return ActionTableViewCellModel(action: ActionPlainObject(text:
        "Будущие события скоро появятся, и вы будете первым, кто про это узнает!".localized
      ))
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
      actionPlainObjects[indexPath.row].action?()
    case .findNearestButtons:
      findNearestPlainObjects[indexPath.row].action?()
    case .collectionIsEmpty:
      break
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

extension MainViewDisplayCollection {

  func needShowSwitchCell() -> Bool {
    guard modelCollection.count > 0 else { return false }
    let event = modelCollection[0]

    var isEventToday = event.startDate.isToday
    #if DEBUG //tested without
      isEventToday = true
    #endif
    //If your Request is Approved And event date is today
    guard event.status == .approved, isEventToday else { return false }

    return true
  }
}

extension MainViewDisplayCollection: PreviewingContentProvider {
  func preview(at indexPath: IndexPath) -> UIViewController? {
    switch sections[indexPath.section] {
    case .events:
      if modelCollection[indexPath.row].isTemplate {
        return nil
      }
      let eventPreviewViewController = Storyboards.EventPreview.instantiateEventPreviewViewController()
      eventPreviewViewController.selectedEventId = modelCollection[indexPath.row].id
      return eventPreviewViewController
    case .actionButtons, .collectionIsEmpty, .findNearestButtons:
      return nil
    }
  }

  func commitPreview(_ viewControllerToCommit: UIViewController) {
    delegate?.push(viewController: viewControllerToCommit)
  }
}
