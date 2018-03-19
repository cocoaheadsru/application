//
//  IBeaconPeripheralMock.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

// swiftlint:disable
import Foundation
@testable import CHMeetupApp

class IBeaconPeripheralMock: IBeaconPeripheral {
  var identifier: UUID = UUID()
  var peripheralObject: Any = UUID()

  var state: BeaconPeripheralState = .disconnected

  // MARK: - discoverServices

  var discoverServicesDelegateCallsCount = 0
  var discoverServicesDelegateCalled: Bool {
    return discoverServicesDelegateCallsCount > 0
  }
  weak var discoverServicesDelegateReceivedDelegate: IBeaconPeripheralDelegate?

  func discoverServices(delegate: IBeaconPeripheralDelegate) {
    discoverServicesDelegateCallsCount += 1
    discoverServicesDelegateReceivedDelegate = delegate
  }

}
// swiftlint:enable
