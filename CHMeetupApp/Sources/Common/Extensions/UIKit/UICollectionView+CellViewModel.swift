//
//  UICollectionView+CellViewModel.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 09/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit.UICollectionView

extension UICollectionView {
  func dequeueReusableCell(for indexPath: IndexPath, with model: CellViewAnyModelType) -> UICollectionViewCell {

    let cellIdentifier = String(describing: model.cellClass())
    let cell = self.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                        for: indexPath)

    model.setup(on: cell)

    return cell
  }
}
