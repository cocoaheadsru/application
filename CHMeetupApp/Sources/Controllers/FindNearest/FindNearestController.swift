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
    let beacons = users.compactMap { (user) -> Beacon? in
      let userInfo = BeaconUserInfo(id: user.id, name: user.name, photoURL: user.photoURL)
      return Beacon(userInfo: userInfo, proximityUUIDString: user.deviceUUID)
    }
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
