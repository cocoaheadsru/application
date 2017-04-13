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
    let loader = KingfisherImageLoader()
    for photoURL in event.speakerPhotosURLs.map({ $0.value }) {
      guard let url = URL(string: photoURL) else { continue }
      _ = loader.loadImage(from: url, completionHandler: { image, _ in
        if let image = image {
          cell.participantsCollectionView.imagesCollection.append(image)
        }
      })
    }
  }
}
