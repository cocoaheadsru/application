//
//  CreatorsTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Sam Mejlumyan on 20/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation

struct CreatorTableViewCellModel: TemplatableCellViewModelType {
  let entity: CreatorEntity
}

extension CreatorTableViewCellModel: CellViewModelType {

  func setup(on cell: CreatorTableViewCell) {
    cell.creatorNameLabel.text = entity.name

    if let photoURL = entity.photoURL, let url = URL(string: photoURL) {
      cell.creatorImage.loadImage(from: url)
    }
  }
}
