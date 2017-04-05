//
//  MapsActionSheetHelper.swift
//  CHMeetupApp
//
//  Created by Alexander Zimin on 06/04/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import CoreLocation

struct MapsActionSheetHelper {
  static func prepareActonSheet(with coordinates: CLLocationCoordinate2D) -> UIViewController? {
    let availableMaps = MapsController.availableMaps
    guard !availableMaps.isEmpty else {
      return nil
    }

    let actionSheet = UIAlertController(title: "Открыть в".localized, message: nil, preferredStyle: .actionSheet)

    for map in MapsController.availableMaps {
      let mapAction = UIAlertAction(title: map.title, style: .default, handler: { (_) in
        MapsController.open(map: map, coordinate: coordinates)
      })
      actionSheet.addAction(mapAction)
    }

    let cancelAction = UIAlertAction(title: "Отмена".localized, style: .cancel, handler: nil)
    actionSheet.addAction(cancelAction)

    return actionSheet
  }
}
