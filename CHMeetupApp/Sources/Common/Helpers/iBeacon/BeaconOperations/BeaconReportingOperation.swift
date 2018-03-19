//
//  BeaconReportingOperation.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 18/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

class BeaconReportingOperation: BeaconOperation {

  private let storage: IBeaconStorage
  private var centralManager: ICentralManager
  private var timer: IBeaconTimer

  weak var delegate: BeaconOperationDelegate?

  var reportDelegateClojure: (() -> BeaconScannerDelegate?)?

  init(storage: IBeaconStorage,
       delegate: BeaconOperationDelegate,
       centralManager: ICentralManager,
       timer: IBeaconTimer = BeaconTimer()) {
    self.storage = storage
    self.delegate = delegate
    self.centralManager = centralManager
    self.timer = timer
  }

  func start() {
    startReportTimer()
  }

  func cancel() {
    timer.invalidate()
  }

  private func startReportTimer() {
    timer.schedule(with: BeaconConstans.Scanner.UpdateInterval,
                   repeats: true) { [weak self] in
                    self?.reportRangesToDelegate()
    }
  }

  private func reportRangesToDelegate() {
    let beacons = storage.processedAndDiscoveredBeacons()
    let now = Date()
    beacons.forEach { (beacon) in
      beacon.checkForPenalty(now: now)
      beacon.calculateProximity()
    }

    let immediateBeacons = beacons.filter { $0.proximityState == .immediate }
    let reportDelegate = reportDelegateClojure?()
    reportDelegate?.serviceFound(beacons: immediateBeacons)
  }
}
