//
//  IBeaconPeripheralDelegateMock.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

// swiftlint:disable
import Foundation
@testable import CHMeetupApp

class IBeaconPeripheralDelegateMock: IBeaconPeripheralDelegate {

  // MARK: - peripheral

  var peripheralGotCallsCount = 0
  var peripheralGotCalled: Bool {
    return peripheralGotCallsCount > 0
  }
  var peripheralGotReceivedArguments: (peripheral: IBeaconPeripheral, data: Data)?

  func peripheral(_ peripheral: IBeaconPeripheral, got data: Data) {
    peripheralGotCallsCount += 1
    peripheralGotReceivedArguments = (peripheral: peripheral, data: data)
  }

  // MARK: - disconnect

  var disconnectPeripheralCallsCount = 0
  var disconnectPeripheralCalled: Bool {
    return disconnectPeripheralCallsCount > 0
  }
  var disconnectPeripheralReceivedPeripheral: IBeaconPeripheral?

  func disconnect( peripheral: IBeaconPeripheral) {
    disconnectPeripheralCallsCount += 1
    disconnectPeripheralReceivedPeripheral = peripheral
  }

}
// swiftlint:enable
