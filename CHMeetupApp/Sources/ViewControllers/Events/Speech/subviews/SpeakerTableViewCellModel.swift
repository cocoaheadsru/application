//
//  SpeakerTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Maxim Globak on 02.04.17.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import UIKit

struct SpeakerTableViewCellModel {
  let speaker: UserEntity
}

extension SpeakerTableViewCellModel: CellViewModelType {
  func setup(on cell: SpeakerTableViewCell) {
    cell.fullNameLabel.text = speaker.name + " " + speaker.lastName

    // Replace with kingfisher or image loading wrapper 
    if let photoURL = speaker.photoURL {
      if let url = URL(string: photoURL) {
        if let photoData = try? Data(contentsOf: url) {
          cell.avatarImageView.image = UIImage(data: photoData)
        } else {
          print("Image not loaded")
        }
      }
    }

    if let position = speaker.position, let company = speaker.company {
      let at = "at".localized
      let description =  position + " " + at + " " + company
      let attributedDescription = configureAttrebutedDescription(description)
      cell.descriptionLabel.attributedText = attributedDescription
    } else {
      cell.descriptionLabel.text = speaker.position ?? speaker.company
    }
  }

  private func configureAttrebutedDescription(_ string: String) -> NSAttributedString {
    let nsString = string as NSString
    let atRange = nsString.range(of: "at".localized)
    let attributtedString = NSMutableAttributedString(string: string)
    attributtedString.addAttribute(NSForegroundColorAttributeName,
                                   value: UIColor(.gray),
                                   range: atRange)
    return attributtedString
  }
}
