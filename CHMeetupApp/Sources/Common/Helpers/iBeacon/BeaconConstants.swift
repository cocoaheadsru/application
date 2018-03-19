//
//  BeaconConstants.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 15/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation
import CoreBluetooth
enum BeaconConstans {

  static let ServiceUUID = CBUUID(string: "8C422626-0C6E-4B86-8EC7-9147B233D97E")
  static let CharacteristicUUID = CBUUID(string: "A05F9DF4-9D54-4600-9224-983B75B9D154")
  static let LocalNameKey = "CocoaHeadsPeer"

  enum Scanner {
    static let ProcessPeripheralInterval = 2.0 //time for scanning new beacons
    static let RestartScanInterval = 2.0 //time for connecting to found beacons
    static let UpdateInterval = 1.0 //
    static let PinaltyScore: Float = -205
    static let PinaltyTimeout: TimeInterval = 3
  }
}
