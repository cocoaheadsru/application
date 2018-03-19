//
//  BeaconReportingOperation.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import XCTest
@testable import CHMeetupApp

final class BeaconReportingOperationTests: XCTestCase {

  // MARK: - Testable object
  var processingOp: BeaconReportingOperation!

  // MARK: - Dependencies
  var storage: IBeaconStorageMock!
  var centralManager: ICentralManagerMock!
  var delegate: BeaconOperationDelegateMock! //swiftlint:disable:this weak_delegate
  var timer: IBeaconTimerMock!
  var scannerDelegateMock: BeaconScannerDelegateMock!

  override func setUp() {
    super.setUp()

    storage = IBeaconStorageMock()
    centralManager = ICentralManagerMock()
    delegate = BeaconOperationDelegateMock()
    timer = IBeaconTimerMock()
    scannerDelegateMock = BeaconScannerDelegateMock()

    processingOp = BeaconReportingOperation(
      storage: storage,
      delegate: delegate,
      centralManager: centralManager,
      timer: timer
    )
    processingOp.reportDelegateClojure = { [weak self] in
      return self?.scannerDelegateMock
    }
  }

  func createBeacons(count: Int) -> [Beacon] {
    return Array(repeating: "", count: count)
      .map { _ in return Beacon(peripheral: IBeaconPeripheralMock()) }
  }

  func testStartOperation() {
    //WHEN
    processingOp.start()

    //THEN
    XCTAssert(timer.scheduleWithRepeatsBlockCalled, "Operation did not start timer")
  }

  func testCancelOperation() {
    //GIVEN
    processingOp.start()
    timer.isValid = true

    //WHEN
    processingOp.cancel()

    //THEN
    XCTAssert(timer.invalidateCalled, "operation did not invalidate timer")
  }

  func testOperationWillReportDelegates() {
    //GIVEN
    processingOp.start()
    timer.isValid = true
    storage.processedAndDiscoveredBeaconsReturnValue = createBeacons(count: 5)

    //WHEN
    timer.performBlock?()

    //THEN
    XCTAssert(storage.processedAndDiscoveredBeaconsCalled,
              "operation did not fetch processed and discovered beacons")
  }

}
