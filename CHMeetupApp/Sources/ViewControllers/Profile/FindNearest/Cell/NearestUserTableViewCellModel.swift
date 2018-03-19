//
//  NearestUserTableViewCellModel.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 16/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

struct NearestUserTableViewCellModel: TemplatableCellViewModelType {
  var entity: NearestUserEntity
}

extension NearestUserTableViewCellModel: CellViewModelType {

  func setup(on cell: CreatorTableViewCell) {
    cell.creatorNameLabel.text = entity.name
  }
}
