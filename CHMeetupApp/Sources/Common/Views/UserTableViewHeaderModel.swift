//
//  UserTableViewHeaderCellModel.swift
//  CHMeetupApp
//
//  Created by Dmitriy Lis on 26/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct UserTableViewHeaderCellModel {
  let userPhoto: UIImage
  let position: String
  let company: String
}

extension UserTableViewHeaderCellModel: CellViewModelType {
  func setup(on cell: UserTableViewHeaderCell) {
    cell.userPhotoView.image = userPhoto

    let attributedString = NSMutableAttributedString()
    if !position.isEmpty && !company.isEmpty {
      attributedString.append(NSAttributedString(string: position,
                                                 attributes: [NSFontAttributeName: UIFont.appFont(.gothamPro(size: 17)),
                                                              NSForegroundColorAttributeName: UIColor(.darkGray)]))
      attributedString.append(NSAttributedString(string: " " + "at".localized + " ",
                                                 attributes: [NSFontAttributeName: UIFont.appFont(.gothamPro(size: 17)),
                                                              NSForegroundColorAttributeName: UIColor(.gray)]))
      attributedString.append(NSAttributedString(string: company,
                                                 attributes: [NSFontAttributeName: UIFont.appFont(.gothamPro(size: 17)),
                                                              NSForegroundColorAttributeName: UIColor(.darkGray)]))
    } else {
      attributedString.append(NSAttributedString(string: position,
                                                 attributes: [NSFontAttributeName: UIFont.appFont(.gothamPro(size: 17)),
                                                              NSForegroundColorAttributeName: UIColor(.darkGray)]))
      attributedString.append(NSAttributedString(string: company,
                                                 attributes: [NSFontAttributeName: UIFont.appFont(.gothamPro(size: 17)),
                                                              NSForegroundColorAttributeName: UIColor(.darkGray)]))
    }
    cell.positionAtCompanyLabel.attributedText = attributedString
  }
}
