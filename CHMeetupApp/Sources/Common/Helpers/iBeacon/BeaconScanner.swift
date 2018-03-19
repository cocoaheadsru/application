//
//  BeaconScanner.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 12/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

protocol BeaconScannerDelegate: class {
  func serviceFound(beacons: [Beacon])
  func bluetoothDidTurnOff()
}

class BeaconScanner {

  // MARK: - Dependecies

  private let storage: IBeaconStorage
  private var centralManager: ICentralManager!

  private var scanningOp: BeaconOperation!
  private var processingOp: BeaconOperation!
  private var reporingOp: BeaconOperation!

  // MARK: - Properties

  private var isDetecting: Bool = false

  weak var delegate: BeaconScannerDelegate?

  init(storage: IBeaconStorage = BeaconStorage(),
       centralManager: ICentralManager = CentralManagerSUT()) {
    self.storage = storage
    self.centralManager = centralManager

    scanningOp = BeaconScanningOperation(storage: storage,
                                         delegate: self,
                                         centralManager: centralManager)
    processingOp = BeaconProcessingOperation(storage: storage,
                                             delegate: self,
                                             centralManager: centralManager)
    let reporingOp = BeaconReportingOperation(storage: storage,
                                          delegate: self,
                                          centralManager: centralManager)
    reporingOp.reportDelegateClojure = { [weak self] in
      return self?.delegate
    }
    self.reporingOp = reporingOp

    centralManager.setOnDidUpdateState { [weak self] _ in
      guard let `self` = self else { return }
      if self.isDetecting {
        self.startIfPossible()
      }
    }

  }

  // MARK: - Public

  public func configure(with beacons: [Beacon]) {
    storage.append(beacons)
  }
  public func startDetecting() {
    isDetecting = true
    startIfPossible()
  }

  public func stopDetecting() {
    isDetecting = false

    scanningOp.cancel()
    processingOp.cancel()
    reporingOp.cancel()
  }

  // MARK: - Private

  private func startIfPossible() {
    switch centralManager.state {
    case .poweredOn:
      startScanning()
    case .poweredOff:
      delegate?.bluetoothDidTurnOff()
      print("unauthorized")
    default:
      print("unknown state of bluetooth Device")
    }
  }
  private func startScanning() {
    reporingOp.start()
    scanningOp.start()

    isDetecting = true
  }
}

extension BeaconScanner: BeaconOperationDelegate {
  func operationDidComplete(operation: BeaconOperation) {
    if operation === scanningOp {
      reporingOp.cancel()
      processingOp.start()
    } else if operation === processingOp {
      startScanning()
    }
  }
}
