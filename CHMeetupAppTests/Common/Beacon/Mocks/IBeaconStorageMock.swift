//
//  IBeaconStorageMock.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

// swiftlint:disable
import Foundation
@testable import CHMeetupApp

class IBeaconStorageMock: IBeaconStorage {

  // MARK: - append

  var appendCallsCount = 0
  var appendCalled: Bool {
    return appendCallsCount > 0
  }
  var appendReceivedBeacons: [Beacon]?

  func append(_ beacons: [Beacon]) {
    appendCallsCount += 1
    appendReceivedBeacons = beacons
  }

  // MARK: - beaconsForDisconnect

  var beaconsForDisconnectCallsCount = 0
  var beaconsForDisconnectCalled: Bool {
    return beaconsForDisconnectCallsCount > 0
  }
  var beaconsForDisconnectReturnValue: [Beacon]!

  func beaconsForDisconnect() -> [Beacon] {
    beaconsForDisconnectCallsCount += 1
    return beaconsForDisconnectReturnValue
  }

  // MARK: - beaconsForConnect

  var beaconsForConnectCallsCount = 0
  var beaconsForConnectCalled: Bool {
    return beaconsForConnectCallsCount > 0
  }
  var beaconsForConnectReturnValue: [Beacon]!

  func beaconsForConnect() -> [Beacon] {
    beaconsForConnectCallsCount += 1
    return beaconsForConnectReturnValue
  }

  // MARK: - appendNew

  var appendNewWithRSSICallsCount = 0
  var appendNewWithRSSICalled: Bool {
    return appendNewWithRSSICallsCount > 0
  }
  var appendNewWithRSSIReceivedArguments: (peripheral: IBeaconPeripheral, RSSI: Float)?

  func appendNew(with peripheral: IBeaconPeripheral, RSSI: Float) {
    appendNewWithRSSICallsCount += 1
    appendNewWithRSSIReceivedArguments = (peripheral: peripheral, RSSI: RSSI)
  }

  // MARK: - beacon

  var beaconWithCallsCount = 0
  var beaconWithCalled: Bool {
    return beaconWithCallsCount > 0
  }
  var beaconWithReceivedPeripheral: IBeaconPeripheral?
  var beaconWithReturnValue: Beacon?!

  func beacon(with peripheral: IBeaconPeripheral) -> Beacon? {
    beaconWithCallsCount += 1
    beaconWithReceivedPeripheral = peripheral
    return beaconWithReturnValue
  }

  // MARK: - isPeripheralsEmpty

  var isPeripheralsEmptyCallsCount = 0
  var isPeripheralsEmptyCalled: Bool {
    return isPeripheralsEmptyCallsCount > 0
  }
  var isPeripheralsEmptyReturnValue: Bool!

  func isPeripheralsEmpty() -> Bool {
    isPeripheralsEmptyCallsCount += 1
    return isPeripheralsEmptyReturnValue
  }

  // MARK: - isAnyDiscoveredAndUnprocessed

  var isAnyDiscoveredAndUnprocessedCallsCount = 0
  var isAnyDiscoveredAndUnprocessedCalled: Bool {
    return isAnyDiscoveredAndUnprocessedCallsCount > 0
  }
  var isAnyDiscoveredAndUnprocessedReturnValue: Bool = false

  func isAnyDiscoveredAndUnprocessed() -> Bool {
    isAnyDiscoveredAndUnprocessedCallsCount += 1
    return isAnyDiscoveredAndUnprocessedReturnValue
  }

  // MARK: - processedAndDiscoveredBeacons

  var processedAndDiscoveredBeaconsCallsCount = 0
  var processedAndDiscoveredBeaconsCalled: Bool {
    return processedAndDiscoveredBeaconsCallsCount > 0
  }
  var processedAndDiscoveredBeaconsReturnValue: [Beacon]!

  func processedAndDiscoveredBeacons() -> [Beacon] {
    processedAndDiscoveredBeaconsCallsCount += 1
    return processedAndDiscoveredBeaconsReturnValue
  }

}
// swiftlint:enable
