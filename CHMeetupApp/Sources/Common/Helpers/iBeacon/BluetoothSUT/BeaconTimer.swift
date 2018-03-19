//
//  BeaconTimer.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

protocol IBeaconTimer {
  func schedule(with interval: TimeInterval,
                repeats: Bool,
                block: @escaping () -> Swift.Void)
  func invalidate()
  var isValid: Bool { get }
}

class BeaconTimer: IBeaconTimer {

  private var timer: Timer?

  func schedule(with interval: TimeInterval,
                repeats: Bool,
                block: @escaping () -> Swift.Void) {
    invalidate()
    timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: repeats, block: { [weak self] _ in
      block()
      self?.invalidate()
    })
  }

  func invalidate() {
    timer?.invalidate()
    timer = nil
  }

  var isValid: Bool {
    return timer?.isValid ?? false
  }
}
