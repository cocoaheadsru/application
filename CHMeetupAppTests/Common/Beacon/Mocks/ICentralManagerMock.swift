//
//  ICentralManagerMock.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

// swiftlint:disable
import Foundation
@testable import CHMeetupApp

class ICentralManagerMock: ICentralManager {

  var state: CentralManagerState = .unknown

  // MARK: - setOnDiscoverPeripheral

  var setOnDiscoverPeripheralCallsCount = 0
  var setOnDiscoverPeripheralCalled: Bool {
    return setOnDiscoverPeripheralCallsCount > 0
  }
  var setOnDiscoverPeripheralReceivedBlock: ((IBeaconPeripheral, Float) -> Void)?

  func setOnDiscoverPeripheral(_ block: @escaping (IBeaconPeripheral, Float) -> Void) {
    setOnDiscoverPeripheralCallsCount += 1
    setOnDiscoverPeripheralReceivedBlock = block
  }

  // MARK: - setOnDidUpdateState

  var setOnDidUpdateStateCallsCount = 0
  var setOnDidUpdateStateCalled: Bool {
    return setOnDidUpdateStateCallsCount > 0
  }
  var setOnDidUpdateStateReceivedBlock: ((CentralManagerState) -> Void)?

  func setOnDidUpdateState(_ block: @escaping (CentralManagerState) -> Void) {
    setOnDidUpdateStateCallsCount += 1
    setOnDidUpdateStateReceivedBlock = block
  }

  // MARK: - setOnDidConnectToPeripheral

  var setOnDidConnectToPeripheralCallsCount = 0
  var setOnDidConnectToPeripheralCalled: Bool {
    return setOnDidConnectToPeripheralCallsCount > 0
  }
  var setOnDidConnectToPeripheralReceivedBlock: ((IBeaconPeripheral) -> Void)?

  func setOnDidConnectToPeripheral(_ block: ((IBeaconPeripheral) -> Void)?) {
    setOnDidConnectToPeripheralCallsCount += 1
    setOnDidConnectToPeripheralReceivedBlock = block
  }

  // MARK: - setOnDidFailToConnectToPeripheral

  var setOnDidFailToConnectToPeripheralCallsCount = 0
  var setOnDidFailToConnectToPeripheralCalled: Bool {
    return setOnDidFailToConnectToPeripheralCallsCount > 0
  }
  var setOnDidFailToConnectToPeripheralReceivedBlock: ((IBeaconPeripheral) -> Void)?

  func setOnDidFailToConnectToPeripheral(_ block: ((IBeaconPeripheral) -> Void)?) {
    setOnDidFailToConnectToPeripheralCallsCount += 1
    setOnDidFailToConnectToPeripheralReceivedBlock = block
  }

  // MARK: - startScan

  var startScanCallsCount = 0
  var startScanCalled: Bool {
    return startScanCallsCount > 0
  }

  func startScan() {
    startScanCallsCount += 1
  }

  // MARK: - stopScan

  var stopScanCallsCount = 0
  var stopScanCalled: Bool {
    return stopScanCallsCount > 0
  }

  func stopScan() {
    stopScanCallsCount += 1
  }

  // MARK: - connect

  var connectCallsCount = 0
  var connectCalled: Bool {
    return connectCallsCount > 0
  }
  var connectReceivedPeripheral: IBeaconPeripheral?

  func connect(_ peripheral: IBeaconPeripheral) {
    connectCallsCount += 1
    connectReceivedPeripheral = peripheral
  }

  // MARK: - disconnect

  var disconnectCallsCount = 0
  var disconnectCalled: Bool {
    return disconnectCallsCount > 0
  }
  var disconnectReceivedPeripheral: IBeaconPeripheral?

  func disconnect(_ peripheral: IBeaconPeripheral) {
    disconnectCallsCount += 1
    disconnectReceivedPeripheral = peripheral
  }

}
// swiftlint:enable
