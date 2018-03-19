//
//  BeaconTransmitter.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 15/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation
import CoreBluetooth

final class BeaconTransmitter: NSObject {

  // MARK: - Properties

  private var peripheralManager: CBPeripheralManager?
  private let identifier: String
  private var isTransmitting = false
  private var bluetoothIsEnabledAndAuthorized = false

  // MARK: - Public

  public init(identifier: String) {
    self.identifier = identifier
    super.init()

    bluetoothIsEnabledAndAuthorized = hasBluetooth()
  }

  public func startTransmitting() {
    guard canTransmit() else {
      return
    }

    startBluetoothTransmitting()
  }

  public func stopTransmitting() {
    isTransmitting = false

    peripheralManager?.stopAdvertising()
    peripheralManager = nil
  }

  // MARK: - Private

  private func canTransmit() -> Bool {
    let status = CBPeripheralManager.authorizationStatus()
    let enabled = status == .authorized || status == .notDetermined
    if !enabled {
      print("bluetooth not authorized")
    }
    return enabled

  }

  private func startBluetoothTransmitting() {
    if peripheralManager == nil {
      peripheralManager?.delegate = self
      peripheralManager = CBPeripheralManager(delegate: self, queue: nil)
    }
  }

  private func hasBluetooth() -> Bool {
    return canTransmit() && peripheralManager?.state == .poweredOn
  }

  private func startAdvertising() {

    let advertisingData: [String: Any] = [
      CBAdvertisementDataLocalNameKey: BeaconConstans.LocalNameKey,
      CBAdvertisementDataServiceUUIDsKey: [BeaconConstans.ServiceUUID]
    ]
    let service = CBMutableService(type: BeaconConstans.ServiceUUID, primary: true)

    let data = identifier.data(using: .utf8)
    let characteristic = CBMutableCharacteristic(
      type: BeaconConstans.CharacteristicUUID,
      properties: .read,
      value: data,
      permissions: .readable
    )
    service.characteristics = [characteristic]
    peripheralManager?.add(service)
    peripheralManager?.startAdvertising(advertisingData)
  }
}

extension BeaconTransmitter: CBPeripheralManagerDelegate {
  func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
    print("-- peripheral state changed: \(peripheral.state)")
    if peripheral.state == .poweredOn {
      startAdvertising()
    }

  }

  func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
    if let err = error {
      print("error starting advertising: \(err.localizedDescription)")
    } else {
      print("did start advertising")
    }
  }
}
