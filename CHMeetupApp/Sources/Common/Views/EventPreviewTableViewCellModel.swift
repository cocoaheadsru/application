//
//  EventPreviewTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 11/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

protocol EventPreviewTableViewCellDelegate: class {
  func acceptButtonDidPressed(on eventCell: EventPreviewTableViewCell)
}

struct EventPreviewTableViewCellModel {
  let event: EventEntity
  let index: Int
  weak var delegate: EventPreviewTableViewCellDelegate?
  let participantsImageNames: [String] = [
    "img_photo_participant-alex",
    "img_photo_participant-sam",
    "img_photo_participant-misha",
    "img_photo_participant-max",
    "img_photo_participant-kirill",
    "img_photo_participant-egor",
    "img_photo_participant-dima"
  ]
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

    var images: [UIImage] = []
    for index in 0 ..< min(event.speakerPhotosURLs.count, participantsImageNames.count) {
      images.append(UIImage(named: participantsImageNames[index])!)
    }
    cell.participantsCollectionView.imagesCollection = images
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
