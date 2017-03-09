//
//  TemplateCollectionCellViewModel.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 09/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

struct TemplateCollectionCellViewModel: CellViewModelType {
  typealias CellClass = UICollectionView

  var backgroundColor: UIColor

  func setup(on cell: UICollectionView) {
    cell.backgroundColor = backgroundColor
  }
}
