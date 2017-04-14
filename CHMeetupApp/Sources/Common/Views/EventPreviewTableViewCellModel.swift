//
//  EventPreviewTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct EventPreviewTableViewCellModel {
  let event: EventEntity
  let index: Int

  let imageLoaderCell = ImageLoaderCellImpl.shared
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

    cell.participantsCollectionView.imagesCollection.removeAll()
    imageLoaderCell.loadImagesCell(cell.hashValue,
                                    urls: event.speakerPhotosURLs.map({ URL(string: $0.value) }).flatMap({ $0 }),
                                    completionHandler: { images in
      cell.participantsCollectionView.imagesCollection = images
    })
  }
}
