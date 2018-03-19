//
//  BeaconUserInfo.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

struct BeaconUserInfo {
  let id: Int
  let name: String
  let photoURL: String?

  var userData: Data? {
    let userInfo: [String: Any] = [
      "id": id,
      "name": name,
      "photo_url": photoURL ?? ""
    ]
    let jsonData = try? JSONSerialization.data(withJSONObject: userInfo, options: .prettyPrinted)
    return jsonData
  }

  static func from(data: Data) -> BeaconUserInfo? {
    guard let userInfo = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
      let id = userInfo?["id"] as? Int,
      let name = userInfo?["name"] as? String else { return nil}

    let photoURL = userInfo?["photo_url"] as? String
    return BeaconUserInfo(id: id, name: name, photoURL: photoURL)
  }
}
