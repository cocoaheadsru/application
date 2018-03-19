//
//  BeaconStorage.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 18/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

protocol IBeaconStorage {
  func append(_ beacons: [Beacon])
  func beaconsForDisconnect() -> [Beacon]
  func beaconsForConnect() -> [Beacon]
  func appendNew(with peripheral: IBeaconPeripheral, RSSI: Float)
  func beacon(with peripheral: IBeaconPeripheral) -> Beacon?
  func isPeripheralsEmpty() -> Bool
  func isAnyDiscoveredAndUnprocessed() -> Bool
  func processedAndDiscoveredBeacons() -> [Beacon]
}

final class BeaconStorage: IBeaconStorage {

  private var beaconsDetected = Set<Beacon>()

  func append(_ beacons: [Beacon]) {
    beacons.forEach { (beacon) in
      self.beaconsDetected.insert(beacon)
    }
  }

  func beaconsForDisconnect() -> [Beacon] {
    return beaconsDetected
      .filter { $0.peripheral?.state == .connecting || $0.peripheral?.state == .connected }
  }

  func beaconsForConnect() -> [Beacon] {
    return beaconsDetected
      .filter { $0.state != .userIDReceived && $0.peripheral != nil }
  }

  func appendNew(with peripheral: IBeaconPeripheral, RSSI: Float) {
    if let beacon = beaconsDetected.first(where: {$0.proximityUUID == peripheral.identifier}) {
      beacon.updatePeripheral(with: peripheral)
      beacon.append(rssi: RSSI)
    } else {
      let beacon = Beacon(peripheral: peripheral)
      beacon.append(rssi: RSSI)
      beaconsDetected.insert(beacon)
    }
  }

  func beacon(with peripheral: IBeaconPeripheral) -> Beacon? {
    return beaconsDetected.first(where: {$0.peripheral?.identifier == peripheral.identifier})
  }

  func isPeripheralsEmpty() -> Bool {
    let processingPeripherals = beaconsDetected.flatMap { $0.peripheral }
    return processingPeripherals.isEmpty
  }

  func isAnyDiscoveredAndUnprocessed() -> Bool {
    let peripherals = beaconsDetected
      .filter { $0.state != .userIDReceived }
      .flatMap { $0.peripheral }
    return !peripherals.isEmpty
  }

  func processedAndDiscoveredBeacons() -> [Beacon] {
    return beaconsDetected.filter { beacon in
      return beacon.state == .userIDReceived && beacon.discovered
    }
  }

  func fetchBeacon(with uuid: UUID) -> Beacon? {
    return beaconsDetected.first(where: { $0.proximityUUID == uuid })
  }
}
