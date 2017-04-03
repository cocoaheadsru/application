//
//  UserTableViewHeaderCellModel.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 26/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct UserTableViewHeaderCellModel {
  let userEntity: UserEntity
}

extension UserTableViewHeaderCellModel: CellViewModelType {
  func setup(on cell: UserTableViewHeaderCell) {
    if let url = URL(string: userEntity.photoURL ?? "") {
      if let data = NSData(contentsOf: url) {
        cell.userImageView.image = UIImage(data: data as Data)
      }
    }

    cell.positionAtCompanyLabel.attributedText =
      AttributedSentenceHelper.concatStringWith(preposition: .at,
                                                optionalFirst: userEntity.position,
                                                optionalSecond: userEntity.company)
  }
}
