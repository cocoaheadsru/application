//
//  BeaconScannerDelegateMock.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

// swiftlint:disable
import Foundation
@testable import CHMeetupApp

class BeaconScannerDelegateMock: BeaconScannerDelegate {

  // MARK: - serviceFound

  var serviceFoundBeaconsCallsCount = 0
  var serviceFoundBeaconsCalled: Bool {
    return serviceFoundBeaconsCallsCount > 0
  }
  var serviceFoundBeaconsReceivedBeacons: [Beacon]?

  func serviceFound(beacons: [Beacon]) {
    serviceFoundBeaconsCallsCount += 1
    serviceFoundBeaconsReceivedBeacons = beacons
  }

  // MARK: - bluetoothDidTurnOff

  var bluetoothDidTurnOffCallsCount = 0
  var bluetoothDidTurnOffCalled: Bool {
    return bluetoothDidTurnOffCallsCount > 0
  }

  func bluetoothDidTurnOff() {
    bluetoothDidTurnOffCallsCount += 1
  }

}
// swiftlint:enable
