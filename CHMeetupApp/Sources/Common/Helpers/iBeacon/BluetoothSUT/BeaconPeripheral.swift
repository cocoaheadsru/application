//
//  BeaconPeripheral.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 18/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol IBeaconPeripheral {
  var identifier: UUID { get }
  var state: BeaconPeripheralState { get }
  var peripheralObject: Any { get }
  func discoverServices(delegate: IBeaconPeripheralDelegate)
}

protocol IBeaconPeripheralDelegate: class {
  func peripheral(_ peripheral: IBeaconPeripheral, got data: Data)
  func disconnect( peripheral: IBeaconPeripheral)
}

final class BeaconPeripheral: NSObject, IBeaconPeripheral {

  private let peripheral: CBPeripheral
  private let services: [CBUUID]
  private let characteritics: [CBUUID]

  weak var delegate: IBeaconPeripheralDelegate?

  init(_ peripheral: CBPeripheral,
       services: [CBUUID] = [BeaconConstans.ServiceUUID],
       characteritics: [CBUUID] = [BeaconConstans.CharacteristicUUID]) {
    self.peripheral = peripheral
    self.services = services
    self.characteritics = characteritics
    super.init()
  }

  var peripheralObject: Any {
    return peripheral
  }

  var identifier: UUID {
    return self.peripheral.identifier
  }

  var state: BeaconPeripheralState {
    return BeaconPeripheralState(rawValue: peripheral.state.rawValue) ?? .disconnected
  }

  func discoverServices( delegate: IBeaconPeripheralDelegate) {
    self.delegate = delegate

    peripheral.delegate = self
    peripheral.discoverServices(services)
  }
}

enum BeaconPeripheralState: Int {
  case disconnected, connecting, connected, disconnecting
}

extension BeaconPeripheral: CBPeripheralDelegate {

  func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
    if error == nil {
      #if DEBUG_BEACON_SCANNING
        print("did discover services: \(peripheral.identifier.uuidString)")
      #endif
      if let service = peripheral.services?.first {
        peripheral.discoverCharacteristics(characteritics, for: service)
      }
    } else {
      delegate?.disconnect(peripheral: self)
    }
  }

  func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
    if error == nil, let characteristic = service.characteristics?.first {
      #if DEBUG_BEACON_SCANNING
        print("did discover characteristics: \(peripheral.identifier.uuidString)")
      #endif
      peripheral.readValue(for: characteristic)
    } else {
      delegate?.disconnect( peripheral: self)
    }
  }

  func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
    defer {
      delegate?.disconnect(peripheral: self)
    }

    guard error == nil,
      let data = characteristic.value else {
        return
    }

    delegate?.peripheral(self, got: data)
  }
}
