//
//  BeaconScanningOperation.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import XCTest
@testable import CHMeetupApp

final class BeaconScanningOperationTests: XCTestCase {

  // MARK: - Testable object
  var scanningOp: BeaconScanningOperation!

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

    scanningOp = BeaconScanningOperation(
      storage: storage,
      delegate: delegate,
      centralManager: centralManager,
      timer: timer
    )
  }

  func testOperationWillStartTimerAndScanning() {
    //WHEN
    scanningOp.start()

    //THEN
    XCTAssert(timer.scheduleWithRepeatsBlockCalled, "operation did not start timer")
    XCTAssert(centralManager.startScanCalled, "centralManager did not start scanning")

  }

  func testCancelOperation() {
    //GIVEN
    scanningOp.start()

    //WHEN
    scanningOp.cancel()

    //THEN
    XCTAssert(timer.invalidateCalled, "operation did not invalidate timer")
    XCTAssert(centralManager.stopScanCalled, "centralManager did not stop scanning on operation canceling")

  }

  func testOperationWillStopScanningOnSuccessComplete() {
    //GIVEN
    storage.isAnyDiscoveredAndUnprocessedReturnValue = true
    scanningOp.start()

    //WHEN
    timer.performBlock?()

    //THEN
    XCTAssert(centralManager.stopScanCalled, "centralManager did not stop scanning")
    XCTAssert(delegate.operationDidCompleteOperationCalled, "Operation did not complete")
  }

  func testOperationRestartOnFailureComplete() {
    //GIVEN
    storage.isAnyDiscoveredAndUnprocessedReturnValue = false
    scanningOp.start()

    //WHEN
    timer.performBlock?()

    //THEN
    XCTAssert(timer.scheduleWithRepeatsBlockCallsCount == 2, "operation did not restart")
    XCTAssert(!delegate.operationDidCompleteOperationCalled, "Operation did complete, but it shout be restarted")
  }

  func testOperationHandleDiscovedPeripherals() {
    //GIVEN
    storage.isAnyDiscoveredAndUnprocessedReturnValue = true
    scanningOp.start()

    //WHEN
    centralManager.setOnDiscoverPeripheralReceivedBlock?(IBeaconPeripheralMock(), -55)
    centralManager.setOnDiscoverPeripheralReceivedBlock?(IBeaconPeripheralMock(), -65)
    centralManager.setOnDiscoverPeripheralReceivedBlock?(IBeaconPeripheralMock(), -75)

    //THEN
    XCTAssert(storage.appendNewWithRSSICallsCount == 3, "Operation did now pass peripherals to storate")
  }
}
