//
//  SpeechPreviewTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 18.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct SpeechPreviewTableViewCellModel: TemplatableCellViewModelType {
  // let speachPreview: SpeachPreviewEntity
  let entity: SpeechEntity
}

extension SpeechPreviewTableViewCellModel {
  func setup(on cell: SpeechPreviewTableViewCell) {
    if let user = entity.user {
      cell.fullNameLabel.text = user.name + " " + user.lastName
      if let photoURL = user.photoURL, let url = URL(string: photoURL) {
        cell.avatarImageView.loadImage(from: url)
      }
    }

    cell.topicLabel.text = "«" + entity.title + "»"
    cell.speachDescriptionLabel.text = entity.descriptionText
  }
}
