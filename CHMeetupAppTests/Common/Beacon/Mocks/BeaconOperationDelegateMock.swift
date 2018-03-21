//
//  BeaconOperationDelegateMock.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

// swiftlint:disable
import Foundation
@testable import CHMeetupApp

class BeaconOperationDelegateMock: BeaconOperationDelegate {

  // MARK: - operationDidComplete

  var operationDidCompleteOperationCallsCount = 0
  var operationDidCompleteOperationCalled: Bool {
    return operationDidCompleteOperationCallsCount > 0
  }
  var operationDidCompleteOperationReceivedOperation: BeaconOperation?

  func operationDidComplete(operation: BeaconOperation) {
    operationDidCompleteOperationCallsCount += 1
    operationDidCompleteOperationReceivedOperation = operation
  }

}
// swiftlint:enable
