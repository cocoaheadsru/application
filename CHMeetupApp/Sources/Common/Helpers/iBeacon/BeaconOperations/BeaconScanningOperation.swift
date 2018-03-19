//
//  BeaconScanningOperation.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 17/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

final class BeaconScanningOperation: BeaconOperation {

  private let storage: IBeaconStorage
  private var centralManager: ICentralManager
  private var timer: IBeaconTimer

  weak var delegate: BeaconOperationDelegate?

  init(storage: IBeaconStorage,
       delegate: BeaconOperationDelegate,
       centralManager: ICentralManager,
       timer: IBeaconTimer = BeaconTimer()) {
    self.storage = storage
    self.delegate = delegate
    self.centralManager = centralManager
    self.timer = timer

    centralManager.setOnDiscoverPeripheral { [weak self] (peripheral, rssi) in
      self?.storage.appendNew(with: peripheral, RSSI: rssi)
    }
  }

  func start() {
    startProcessPeripheralsTimer()
    centralManager.startScan()
  }

  func cancel() {
    centralManager.stopScan()
    timer.invalidate()
  }

  private func startProcessPeripheralsTimer() {
    timer.schedule(with: BeaconConstans.Scanner.ProcessPeripheralInterval,
                   repeats: false,
                   block: { [weak self] in
      self?.processPeripherals()
    })
  }

  private func processPeripherals() {
    if storage.isAnyDiscoveredAndUnprocessed() {
      centralManager.stopScan()
      delegate?.operationDidComplete(operation: self)
    } else {
      startProcessPeripheralsTimer()
    }
  }

}
