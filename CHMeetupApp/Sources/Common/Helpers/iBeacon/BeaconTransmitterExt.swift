//
//  BeaconTransmitterExt.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 17/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

private var transmitter: BeaconTransmitter?

extension BeaconTransmitter {

  public static func setUser(isAuthorized: Bool) {
    if isAuthorized {
      if let user = UserPreferencesEntity.value.currentUser {
        transmitter = BeaconTransmitter(identifier: "\(user.remoteId),\(user.name)") // name only for MVP
      }
      transmitter?.startTransmitting()
    } else {
      transmitter?.stopTransmitting()
      transmitter = nil
    }
  }
}
