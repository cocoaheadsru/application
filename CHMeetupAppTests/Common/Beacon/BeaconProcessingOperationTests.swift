//
//  BeaconProcessingOperationTests.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import XCTest
@testable import CHMeetupApp

final class BeaconProcessingOperationTests: XCTestCase {

  // MARK: - Testable object
  var processingOp: BeaconProcessingOperation!

  // MARK: - Dependencies
  var storage: IBeaconStorageMock!
  var centralManager: ICentralManagerMock!
  var delegate: BeaconOperationDelegateMock! //swiftlint:disable:this weak_delegate
  var timer: IBeaconTimerMock!

  override func setUp() {
    super.setUp()

    storage = IBeaconStorageMock()
    centralManager = ICentralManagerMock()
    delegate = BeaconOperationDelegateMock()
    timer = IBeaconTimerMock()

    processingOp = BeaconProcessingOperation(
      storage: storage,
      delegate: delegate,
      centralManager: centralManager,
      timer: timer
    )
  }

  func createBeacons(count: Int) -> [Beacon] {
    return Array(repeating: "", count: count)
      .map { _ in return Beacon(peripheral: IBeaconPeripheralMock()) }
  }

  func testStartOperation() {
    //GIVEN
    let beaconCount = 2
    storage.beaconsForConnectReturnValue = createBeacons(count: beaconCount)

    //WHEN
    processingOp.start()

    //THEN
    XCTAssert(storage.beaconsForConnectCalled, "Operation did not fetch Beacons")
    XCTAssert(centralManager.connectCallsCount == beaconCount,
              "Operation did not connect to all beacons, count \(beaconCount)")
    XCTAssert(timer.scheduleWithRepeatsBlockCalled, "Operation did not start timer")
  }

  func testCancelOperation() {
    //GIVEN
    let beaconCount = 3
    storage.beaconsForConnectReturnValue = createBeacons(count: beaconCount)
    storage.beaconsForDisconnectReturnValue = createBeacons(count: beaconCount)
    processingOp.start()
    timer.isValid = true

    //WHEN
    processingOp.cancel()

    //THEN
    XCTAssert(timer.invalidateCalled, "operation did not invalidate timer")
    XCTAssert(storage.beaconsForDisconnectCalled, "operation did not fetch beacons for disconnect from storage")
    XCTAssert(centralManager.disconnectCallsCount == beaconCount, "operation did not try to disctonnect from beacons")
    XCTAssert(delegate.operationDidCompleteOperationCalled, "operation did call complete function to delegate")
  }

  func testOperationCompleteProcessing() {
    //GIVEN
    let beaconCount = 4
    storage.beaconsForConnectReturnValue = createBeacons(count: beaconCount)
    storage.beaconsForDisconnectReturnValue = createBeacons(count: beaconCount)
    processingOp.start()

    //WHEN
    timer.performBlock?()

    //THEN
    XCTAssert(storage.beaconsForDisconnectCalled, "operation did not fetch beacons for disconnect from storage")
    XCTAssert(centralManager.disconnectCallsCount == beaconCount, "operation did not try to disctonnect from beacons")
    XCTAssert(delegate.operationDidCompleteOperationCalled, "operation did call complete function to delegate")
  }

  func testOperationWillHandleConnectedPeriphephals() {
    //GIVEN
    let peripheral = IBeaconPeripheralMock()
    storage.beaconWithReturnValue = Beacon(peripheral: peripheral)

    //WHEN
    centralManager.setOnDidConnectToPeripheralReceivedBlock?(peripheral)

    //THEN
    XCTAssert(storage.beaconWithCalled, "operation did not fetch beacon for peripheral")
    XCTAssert(peripheral.discoverServicesDelegateCalled,
              "operation did not try to discover services for given peripheral")
  }

  func testOperationWillHandleReceivedData() {
    //GIVEN
    let peripheral = IBeaconPeripheralMock()
    let userInfo = (id: 2, name: "China")
    let data = "\(userInfo.id),\(userInfo.name)".data(using: .utf8)!
    let beacon = Beacon(peripheral: peripheral)
    storage.beaconWithReturnValue = beacon

    //WHEN
    processingOp.peripheral(peripheral, got: data)

    //THEN
    XCTAssert(storage.beaconWithCalled, "Operation did not fetch beacon for given peripheral")
    XCTAssert(
      beacon.userID == userInfo.id,
      "Operation did handle userID incorrectly (got \(beacon.userID), should \(userInfo.id)")
    XCTAssert(beacon.userName == userInfo.name,
              "Operation did handle username incorrectly (got \(beacon.userName), should \(userInfo.name)")
  }

  func testOperationWillDisconnectFromPeripheral() {
    //GIVEN
    let peripheral = IBeaconPeripheralMock()
    let beacon = Beacon(peripheral: peripheral)
    storage.beaconWithReturnValue = beacon
    storage.isPeripheralsEmptyReturnValue = true

    //WHEN
    processingOp.disconnect(peripheral: peripheral)

    //THEN
    XCTAssert(storage.beaconWithCalled, "Operation did not fetch beacon for given peripheral")
    XCTAssertNil(beacon.peripheral, "Operation did not reset peripheral in given beacon")
    XCTAssert(centralManager.disconnectCalled, "Operation did no try disconnect from peripheral")
    XCTAssert(
      centralManager.disconnectReceivedPeripheral?.identifier == peripheral.identifier,
      "Operation did try to disconnnect from incorrect peripheral")
  }

}
