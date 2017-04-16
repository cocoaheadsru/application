//
//  EventPreviewTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol EventPreviewTableViewCellDelegate: class {
  func acceptButtonPressed(on eventCell: EventPreviewTableViewCell)
}

struct EventPreviewTableViewCellModel {
  let event: EventEntity
  let index: Int
  weak var delegate: EventPreviewTableViewCellDelegate?
  let groupImageLoader: GroupImageLoader
}

extension EventPreviewTableViewCellModel: CellViewModelType {
  func setup(on cell: EventPreviewTableViewCell) {
    cell.eventImageView.image = #imageLiteral(resourceName: "img_event_template")
    cell.nameLabel.text = event.title
    cell.dateLabel.text = event.startDate.defaultFormatString

    if let place = event.place {
      cell.placeLabel.text = place.city + ", " + place.title
    }

    cell.isEnabledForRegistration = event.isRegistrationOpen
    cell.delegate = delegate
    cell.participantsCollectionView.imagesCollection.removeAll()
    let urls = event.speakerPhotosURLs.map { URL(string: $0.value) }.flatMap { $0 } as [URL]
    groupImageLoader.loadImages(groupId: cell.hashValue,
                                urls: urls,
                                completionHandler: { images in
      cell.participantsCollectionView.imagesCollection = images
    })
  }
}
