//
//  FindNearestController.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 12/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

class FindNearestController {

  private lazy var beaconScanner = BeaconScanner()
  private var onNearestUsersUpdated: (() -> Void)?

  init() {
    configureScanner()
  }

  func startScanning() {
    beaconScanner.startDetecting()
  }

  func stopScanning() {
    beaconScanner.stopDetecting()
    resetAll()
  }

  private func configureScanner() {
    resetAll()
    beaconScanner.configure(with: allBeacons())
    beaconScanner.delegate = self
  }

  private func resetAll() {
    NearestUserEntity.resetDiscoveredStatus()
  }

  deinit {
    stopScanning()
  }

  func setOnNearestUsersUpdated(_ clojure: (() -> Void)?) {
    onNearestUsersUpdated = clojure
  }

  private func allBeacons() -> [Beacon] {
    let users = Array(mainRealm.objects(NearestUserEntity.self))
    let beacons = users.flatMap { Beacon(userID: $0.id, proximityUUIDString: $0.deviceUUID, name: $0.name) }
    return beacons
  }
}

extension FindNearestController: BeaconScannerDelegate {
  func serviceFound(beacons: [Beacon]) {
    NearestUserPlainObjectTranslation.translate(of: beacons, to: nil)
    onNearestUsersUpdated?()
  }

  func bluetoothDidTurnOff() {

  }
}
