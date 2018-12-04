//
//  MapAppType.swift
//  MapsPlayground
//
//  Created by Alexander Zimin on 23/02/2017.
//  Copyright © 2017 CocoaHeads Community. All rights reserved.
//

import Foundation
import CoreLocation

enum MapAppType: CaseIterable {
  case appleMaps
  case googleMaps
  case yandexMaps
  case yandexNavigation
  case doubleGIS

  var title: String {
    switch self {
    case .appleMaps:
      return "Apple Maps"
    case .googleMaps:
      return "Google Maps"
    case .yandexMaps:
      return "Yandex Maps"
    case .yandexNavigation:
      return "Yandex Navigation"
    case .doubleGIS:
      return "2GIS"
    }
  }

  var scheme: URL {
    let schemeString: String
    switch self {
    case .appleMaps:
      schemeString = "http://maps.apple.com"
    case .googleMaps:
      schemeString = "comgooglemaps://"
    case .yandexMaps:
      schemeString = "yandexmaps://maps.yandex.ru/"
    case .yandexNavigation:
      schemeString = "yandexnavi://"
    case .doubleGIS:
      schemeString = "dgis://2gis.ru/"
    }
    return URL(string: schemeString)!
  }

  func scheme(with place: PlaceEntity) -> URL {
    let schemeSuffix: String

    let coordinate = CLLocationCoordinate2D(latitude: place.latitude, longitude: place.longitude)

    switch self {
    case .appleMaps:
      // swiftlint:disable:next line_length
      // https://developer.apple.com/library/content/featuredarticles/iPhoneURLScheme_Reference/MapLinks/MapLinks.html#//apple_ref/doc/uid/TP40007899-CH5-SW1
      schemeSuffix = "?q=\(coordinate.latitude),\(coordinate.longitude)"
    case .googleMaps:
      // https://developers.google.com/maps/documentation/ios-sdk/urlscheme
      schemeSuffix = "?q=\(coordinate.latitude),\(coordinate.longitude)"
    case .yandexMaps:
      // http://stackoverflow.com/questions/22127840/ios-launch-yandexmaps-with-directions-urlscheme
      schemeSuffix = "?pt=\(coordinate.longitude),\(coordinate.latitude)&z=15"
    case .yandexNavigation:
      // https://github.com/yandexmobile/yandexmapkit-ios/wiki/Интеграция-с-Яндекс.Навигатором
      schemeSuffix = "build_route_on_map?lat_to=\(coordinate.latitude)&lon_to=\(coordinate.longitude)"
    case .doubleGIS:
      let cyrillicSymbols = "search/\(place.address)"
      schemeSuffix = cyrillicSymbols.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    return URL(string: scheme.absoluteString + schemeSuffix)!
  }

}
