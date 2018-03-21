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

  public static func turnOn() {
    if let user = UserPreferencesEntity.value.currentUser,
      let data = prepareData(for: user) {
      transmitter = BeaconTransmitter(userData: data)
    }
    transmitter?.startTransmitting()
  }

  public static func turnOff() {
    transmitter?.stopTransmitting()
    transmitter = nil
  }

  public static func isTurnedOn() -> Bool {
    return transmitter?.isTransmitting == true
  }

  private static func prepareData(for user: UserEntity) -> Data? {
    return BeaconUserInfo(id: user.id, name: user.fullName, photoURL: user.photoURL).userData
  }
}
