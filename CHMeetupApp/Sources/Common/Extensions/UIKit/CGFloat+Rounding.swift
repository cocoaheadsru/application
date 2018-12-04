//
//  CGFloat+Rounding.swift
//  CHMeetupApp
//
//  Created by Dima on 17/03/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit

extension CGFloat {
  func round(_ nearest: CGFloat) -> CGFloat {
    let сoefficient = 1 / nearest
    let numberToRound = self * сoefficient
    return numberToRound.rounded() / сoefficient
  }
}
