//
//  IBeaconTimer.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

// swiftlint:disable
import Foundation
@testable import CHMeetupApp

class IBeaconTimerMock: IBeaconTimer {

  // MARK: - schedule

  var scheduleWithRepeatsBlockCallsCount = 0
  var scheduleWithRepeatsBlockCalled: Bool {
    return scheduleWithRepeatsBlockCallsCount > 0
  }
  typealias LargeTuple = (interval: TimeInterval, repeats: Bool, block: () -> Swift.Void)
  var scheduleWithRepeatsBlockReceivedArguments: LargeTuple?

  var performBlock: (() -> Swift.Void?)?

  func schedule(with interval: TimeInterval, repeats: Bool, block: @escaping () -> Swift.Void) {
    self.performBlock = block
    scheduleWithRepeatsBlockCallsCount += 1
    scheduleWithRepeatsBlockReceivedArguments = (interval: interval, repeats: repeats, block: block)
  }

  // MARK: - invalidate

  var invalidateCallsCount = 0
  var invalidateCalled: Bool {
    return invalidateCallsCount > 0
  }

  func invalidate() {
    invalidateCallsCount += 1
  }

  var isValid: Bool = false
}
// swiftlint:enable
