//
//  BeaconOperationMock.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

// swiftlint:disable large_tuple
import Foundation
@testable import CHMeetupApp

class BeaconOperationMock: BeaconOperation {
  weak var delegate: BeaconOperationDelegate?

  // MARK: - init

  var initStorageDelegateCentralManagerReceivedArguments: (
    storage: IBeaconStorage,
    delegate: BeaconOperationDelegate,
    centralManager: ICentralManager
  )?

  required init(storage: IBeaconStorage,
                delegate: BeaconOperationDelegate,
                centralManager: ICentralManager) {
    initStorageDelegateCentralManagerReceivedArguments
      = (storage: storage, delegate: delegate, centralManager: centralManager)
  }

  // MARK: - start

  var startCallsCount = 0
  var startCalled: Bool {
    return startCallsCount > 0
  }

  func start() {
    startCallsCount += 1
  }

  // MARK: - cancel

  var cancelCallsCount = 0
  var cancelCalled: Bool {
    return cancelCallsCount > 0
  }

  func cancel() {
    cancelCallsCount += 1
  }

}
// swiftlint:enable large_tuple
