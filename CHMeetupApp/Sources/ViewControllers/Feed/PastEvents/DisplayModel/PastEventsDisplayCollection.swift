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

  let modelCollection: DataModelCollection<EventEntity> = {
    let predicate = NSPredicate(format: "endDate < %@", NSDate())
    let modelCollection = DataModelCollection(type: EventEntity.self).filtered(predicate)
    return modelCollection
  }()

  weak var delegate: DisplayCollectionDelegate?
  weak var getTableViewDelegate: TableViewGetDelegate?

  var numberOfSections: Int {
    return 1
  }

  func numberOfRows(in section: Int) -> Int {
    return modelCollection.count
  }

  func model(for indexPath: IndexPath) -> CellViewAnyModelType {
    return EventPreviewTableViewCellModel(event: modelCollection[indexPath.row], index: indexPath.row, delegate: self)
  }

  func didSelect(indexPath: IndexPath) {
    let eventPreview = Storyboards.EventPreview.instantiateEventPreviewViewController()
    eventPreview.selectedEventId = modelCollection[indexPath.row].id
    delegate?.push(viewController: eventPreview)
  }
}

extension PastEventsDisplayCollection: EventPreviewTableViewCellDelegate {
  func acceptButtonDidPressed(on eventCell: EventPreviewTableViewCell) {
    let viewController = Storyboards.EventPreview.instantiateRegistrationPreviewViewController()
    guard let indexPath = getTableViewDelegate?.getIndexPath(from: eventCell) else {
      assertionFailure("IndexPath is unknown")
      return
    }
    _ = modelCollection[indexPath.row] // event
    // TODO: - send model
    delegate?.push(viewController: viewController)
  }
}
