//
//  PastEventsDisplayCollection.swift
//  CHMeetupApp
//
//  Created by Denis on 03.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

final class PastEventsDisplayCollection: DisplayCollection, DisplayCollectionAction {
  static var modelsForRegistration: [CellViewAnyModelType.Type] {
    return [EventPreviewTableViewCellModel.self]
  }

  var modelCollection: TemplateModelCollection<EventEntity> = {
    let predicate = NSPredicate(format: "endDate < %@", NSDate())
    var dataCollection = DataModelCollection(type: EventEntity.self).filtered(predicate)
    dataCollection = dataCollection.sorted(byKeyPath: #keyPath(EventEntity.endDate), ascending: false)
    return TemplateModelCollection(dataCollection: dataCollection)
  }()

  init() {
    modelCollection.delegate = self
  }

  weak var delegate: DisplayCollectionWithTableViewDelegate?

  let groupImageLoader = GroupImageLoader.standard

  var numberOfSections: Int {
    return 1
  }

  func numberOfRows(in section: Int) -> Int {
    return modelCollection.count
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    return EventPreviewTableViewCellModel(entity: modelCollection[indexPath.row],
                                          index: indexPath.row,
                                          delegate: self,
                                          groupImageLoader: groupImageLoader)
  }

  func didSelect(indexPath: IndexPath) {
    if !modelCollection[indexPath.row].isTemplate {
      let eventPreview = Storyboards.EventPreview.instantiateEventPreviewViewController()
      eventPreview.selectedEventId = modelCollection[indexPath.row].id
      delegate?.push(viewController: eventPreview)
    }
  }
}

extension PastEventsDisplayCollection: TemplateModelCollectionDelegate {
  func templateModelCollectionDidUpdateData() {
    delegate?.updateUI()
  }
}

extension PastEventsDisplayCollection: EventPreviewTableViewCellDelegate {
  func eventCellAcceptButtonPressed(_ eventCell: EventPreviewTableViewCell) {
    let viewController = Storyboards.EventPreview.instantiateRegistrationPreviewViewController()
    guard let indexPath = delegate?.getIndexPath(from: eventCell) else {
      assertionFailure("IndexPath is unknown")
      return
    }
    viewController.selectedEventId = modelCollection[indexPath.row].id
    delegate?.push(viewController: viewController)
  }
}
