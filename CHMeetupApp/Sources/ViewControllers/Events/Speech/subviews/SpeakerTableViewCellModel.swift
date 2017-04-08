//
//  SpeakerTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 02.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct SpeakerTableViewCellModel {
  let speaker: UserEntity
}

extension SpeakerTableViewCellModel: CellViewModelType {
  func setup(on cell: SpeakerTableViewCell) {
    cell.fullNameLabel.text = speaker.fullName

    // Replace with kingfisher or image loading wrapper 
    if let photoURL = speaker.photoURL, let url = URL(string: photoURL), let photoData = try? Data(contentsOf: url) {
        cell.avatarImageView.image = UIImage(data: photoData)
    }

    cell.descriptionLabel.attributedText =
    AttributedSentenceHelper.concatString(with: .at,
                                          firstPartString: speaker.position,
                                          secondPartString: speaker.company)
  }
}
