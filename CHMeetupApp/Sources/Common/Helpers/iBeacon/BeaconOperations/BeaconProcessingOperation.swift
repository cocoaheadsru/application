//
//  BeaconProcessingOperation.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 18/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

final class BeaconProcessingOperation: BeaconOperation {

  fileprivate let storage: IBeaconStorage
  private var centralManager: ICentralManager!
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

    centralManager.setOnDidConnectToPeripheral { [weak self] (peripheral) in
      guard let `self` = self else { return }
      let beacon = self.storage.beacon(with: peripheral)
      beacon?.peripheral?.discoverServices(delegate: self)
    }
  }

  func start() {
    let peripherals = storage.beaconsForConnect().flatMap { $0.peripheral }
    peripherals.forEach { peripheral in
      self.centralManager.connect(peripheral)
    }

    startProcessingTimer()

  }

  func cancel() {
    if timer.isValid {
      timer.invalidate()
      stopProcessing()
    }
  }

  private func startProcessingTimer() {
    timer.schedule(with: BeaconConstans.Scanner.RestartScanInterval,
                   repeats: false) { [weak self] in
                    self?.stopProcessing()
    }
  }

  private func stopProcessing() {
    let peripherals = storage.beaconsForDisconnect().flatMap { $0.peripheral }
    peripherals.forEach { peripheral in
      centralManager.disconnect(peripheral)
    }
    delegate?.operationDidComplete(operation: self)
  }
}

extension BeaconProcessingOperation: IBeaconPeripheralDelegate {

  func peripheral(_ peripheral: IBeaconPeripheral, got data: Data) {
    guard let beacon = storage.beacon(with: peripheral) else {
        return
    }
    beacon.updateValues(with: data)
  }

  func disconnect(peripheral: IBeaconPeripheral) {
    let beacon = storage.beacon(with: peripheral)
    beacon?.updatePeripheral(with: nil)
    centralManager.disconnect(peripheral)
    if storage.isPeripheralsEmpty() {
      cancel()
    }
  }

}
