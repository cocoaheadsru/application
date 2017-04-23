//
//  CreatorsTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 20/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct CreatorTableViewCellModel {
  let creator: UserPlainObject
  init(creator: UserPlainObject) {
    self.creator = creator
  }
}

extension CreatorTableViewCellModel: CellViewModelType {

  func setup(on cell: CreatorTableViewCell) {
    cell.creatorNameLabel.text = creator.name

    if let photoURL = creator.photoUrl, let url = URL(string: photoURL) {
      cell.creatorImage.loadImage(from: url)
    }
  }

}
