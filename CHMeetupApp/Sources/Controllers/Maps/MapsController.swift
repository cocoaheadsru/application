//
//  MapsController.swift
//  MapsPlayground
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import UIKit
import CoreLocation

struct MapsController {
  static var availableMaps: [MapAppType] {
    return MapAppType.allCases.filter({ map in
      UIApplication.shared.canOpenURL(map.scheme)
    })
  }

  static func open(map: MapAppType, place: PlaceEntity) {
    let schemeURL = map.scheme(with: place)
    UIApplication.shared.open(schemeURL, options: [:], completionHandler: nil)
  }
}
