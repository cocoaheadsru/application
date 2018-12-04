//
//  Beacon.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 15/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

class Beacon: NSObject {

  internal let proximityUUID: UUID

  private(set) var userInfo: BeaconUserInfo? {
    didSet {
      if userInfo != nil {
        self.state = .userInfoReceived
      }
    }
  }
  private(set) var rssiStack: [Float] = []
  private(set) var lastRSSIAppended = Date()

  private(set) var state: BeaconState = .notEnoughRSSIData
  private(set) var proximityState: ProximityState = .unknown

  private(set) var peripheral: IBeaconPeripheral?

  init(peripheral: IBeaconPeripheral) {
    self.peripheral = peripheral
    self.proximityUUID = peripheral.identifier
  }

  init?(userInfo: BeaconUserInfo, proximityUUIDString: String) {
    guard let uuid = UUID(uuidString: proximityUUIDString) else { return nil }
    self.userInfo = userInfo
    self.proximityUUID = uuid
    self.state = .userInfoReceived
  }

  func append(rssi: Float) {
    rssiStack = rssiStack.filter { $0 > BeaconConstans.Scanner.pinaltyScore } //I'm alive -> remove aging values
    rssiStack.append(rssi)
    while rssiStack.count > 10 {
      rssiStack.remove(at: 0)
    }
    self.lastRSSIAppended = Date()
  }

  func checkForPenalty(now: Date = Date()) {
    // Check beacon did discovered in last 3 seconds, if no, than give them pinalty
    guard state == .userInfoReceived else { return }
    if abs(now.timeIntervalSince(lastRSSIAppended)) > BeaconConstans.Scanner.pinaltyTimeout {
      //pinalty
      rssiStack.append(BeaconConstans.Scanner.pinaltyScore)
    }

  }

  func updateValues(with data: Data) {
    guard let userInfo = BeaconUserInfo.from(data: data) else {
      return
    }
    self.userInfo = userInfo
    self.peripheral = nil

  }

  func updatePeripheral(with peripheral: IBeaconPeripheral?) {
    self.peripheral = peripheral
  }

  func calculateProximity() {
    var proximity: Float = 0
    let rssiStack = self.rssiStack

    var index: Float = 0
    rssiStack.forEach { (rssi) in
      if rssi > -25 {
        var tempVal: Float = 0
        if index > 0 {
          tempVal = proximity / index
        }
        if tempVal > -25 {
          tempVal = -55
        }
        proximity += tempVal
      } else {
        proximity += rssi
      }
      index+=1
    }
    proximity /= 10.0
    var state: ProximityState
    if proximity < -200 {
      state = .unknown
    } else if proximity < -90 {
      state = .far
    } else if proximity < -72 {
      state = .near
    } else if proximity < 0 {
      state = .immediate
    } else {
      state = .unknown
    }
    self.proximityState = state
  }

  var discovered: Bool {
    return !rssiStack.isEmpty
  }
}

enum BeaconState {
  case notEnoughRSSIData
  case connecting
  case userInfoReceived
}

enum ProximityState: Int {
  case immediate
  case near
  case far
  case unknown
}
