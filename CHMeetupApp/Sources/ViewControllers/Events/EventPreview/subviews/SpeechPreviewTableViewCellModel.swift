//
//  SpeechPreviewTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 18.03.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct SpeechPreviewTableViewCellModel {
  // let speachPreview: SpeachPreviewEntity
  let speech: SpeechEntity
}

extension SpeechPreviewTableViewCellModel: CellViewModelType {
  func setup(on cell: SpeechPreviewTableViewCell) {
    if let user = speech.user {
      //    cell.avatarImageView.image = UIImage(data: userPhoto)
      cell.fullNameLabel.text = user.name + " " + user.lastName
    }

    cell.topicLabel.text = "«" + speech.title + "»"
    cell.speachDescriptionLabel.text = speech.descriptionText
  }
}
