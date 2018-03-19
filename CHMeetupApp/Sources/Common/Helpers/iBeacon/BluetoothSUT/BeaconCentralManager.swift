//
//  BeaconCentralManager.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 18/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation
import CoreBluetooth

protocol ICentralManager {
  func setOnDiscoverPeripheral(_ block: @escaping (IBeaconPeripheral, Float) -> Void)
  func setOnDidUpdateState(_ block: @escaping (CentralManagerState) -> Void)
  func setOnDidConnectToPeripheral(_ block: ((IBeaconPeripheral) -> Void)?)
  func setOnDidFailToConnectToPeripheral(_ block: ((IBeaconPeripheral) -> Void)?)

  var state: CentralManagerState { get }

  func startScan()
  func stopScan()
  func connect(_ peripheral: IBeaconPeripheral)
  func disconnect(_ peripheral: IBeaconPeripheral)
}

enum CentralManagerState: Int {
  case unknown, resetting, unsupported, unauthorized, poweredOff, poweredOn
}

final class CentralManagerSUT: NSObject {
  private var centralManager: CBCentralManager!
  private let serviceUUID: CBUUID

  private var onDiscoverPeripheral: ((IBeaconPeripheral, Float) -> Void)?
  private var onDidUpdateState: ((CentralManagerState) -> Void)?
  private var onDidConnectToPeripheral: ((IBeaconPeripheral) -> Void)?
  private var onDidFailToConnectToPeripheral: ((IBeaconPeripheral) -> Void)?

  private let scanOptions: [String: Any] = [CBCentralManagerScanOptionAllowDuplicatesKey: true]

  var state: CentralManagerState {
    return CentralManagerState(rawValue: centralManager.state.rawValue) ?? .unknown
  }

  init(queue: DispatchQueue? = nil, serviceUUID: CBUUID = BeaconConstans.ServiceUUID) {
    self.serviceUUID = serviceUUID
    super.init()
    self.centralManager = CBCentralManager(delegate: self, queue: queue)
  }
}

extension CentralManagerSUT: ICentralManager {
  func setOnDidConnectToPeripheral(_ block: ((IBeaconPeripheral) -> Void)?) {
    onDidConnectToPeripheral = block
  }

  func setOnDidFailToConnectToPeripheral(_ block: ((IBeaconPeripheral) -> Void)?) {
    onDidFailToConnectToPeripheral = block
  }

  func setOnDiscoverPeripheral(_ block: @escaping (IBeaconPeripheral, Float) -> Void) {
    onDiscoverPeripheral = block
  }

  func setOnDidUpdateState(_ block: @escaping (CentralManagerState) -> Void) {
    onDidUpdateState = block
  }

  func startScan() {
    centralManager.scanForPeripherals(
      withServices: [serviceUUID],
      options: scanOptions
    )
  }

  func stopScan() {
    centralManager.stopScan()
  }

  func connect(_ peripheral: IBeaconPeripheral) {
    if let peripheralObj = peripheral.peripheralObject as? CBPeripheral {
      centralManager.connect(peripheralObj, options: nil)
    }
  }

  func disconnect(_ peripheral: IBeaconPeripheral) {
    if let peripheralObj = peripheral.peripheralObject as? CBPeripheral {
      centralManager.cancelPeripheralConnection(peripheralObj)
    }
  }
}

extension CentralManagerSUT: CBCentralManagerDelegate {
  func centralManagerDidUpdateState(_ central: CBCentralManager) {
    onDidUpdateState?(state)
  }

  func centralManager(_ central: CBCentralManager,
                      didDiscover peripheral: CBPeripheral,
                      advertisementData: [String: Any],
                      rssi RSSI: NSNumber) {
    #if DEBUG_BEACON_SCANNING
      print("did discover peripheral: \(peripheral.identifier.uuidString), \(RSSI.floatValue)")
    #endif

    let beaconPeripheral = BeaconPeripheral(peripheral)
    onDiscoverPeripheral?(beaconPeripheral, RSSI.floatValue)
  }

  func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
    #if DEBUG_BEACON_SCANNING
      print("did connect peripheral: \(peripheral.identifier.uuidString)")
    #endif

    let beaconPeripheral = BeaconPeripheral(peripheral)
    onDidConnectToPeripheral?(beaconPeripheral)

  }

  func centralManager(_ central: CBCentralManager, didFailToConnect peripheral: CBPeripheral, error: Error?) {
    if let err = error {
      #if DEBUG_BEACON_SCANNING
        print("fail connect peripheral: \(err)")
      #endif
    }
    let beaconPeripheral = BeaconPeripheral(peripheral)
    onDidFailToConnectToPeripheral?(beaconPeripheral)
  }
}
