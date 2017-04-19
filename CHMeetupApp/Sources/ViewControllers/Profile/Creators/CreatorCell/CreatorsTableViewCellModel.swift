//
//  CreatorsTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 20/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct CreatorTableViewCellModel {
  let creator: UserEntity
}

extension CreatorTableViewCellModel: CellViewModelType {

  func setup(on cell: CreatorTableViewCell) {
    cell.creatorNameLabel.text = creator.fullName
    /*
    if let photoURL = creator.photoURL, let url = URL(string: photoURL) {
      cell.creatorImage.loadImage(from: url)
    }*/
  }

}
