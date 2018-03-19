//
//  BeaconStorageTests.swift
//  CHMeetupAppTests
//
//  Created by Chingis Gomboev on 19/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import XCTest
@testable import CHMeetupApp

final class BeaconStorageTests: XCTestCase {

  // MARK: - Testable object
  var storage: BeaconStorage!

  // MAEK: - Dependecies

  override func setUp() {
    super.setUp()

    storage = BeaconStorage()

  }

  func mockPeripheral(with state: BeaconPeripheralState,
                      periperal: IBeaconPeripheralMock? = nil) -> IBeaconPeripheralMock {
    let mock = periperal ?? IBeaconPeripheralMock()
    mock.state = state
    return mock
  }

  func testBeaconsForConnect() {
    //GIVEN
    let peripheral = IBeaconPeripheralMock()
    let beacon = Beacon(userID: 1, proximityUUIDString: UUID().uuidString, name: "China")!
    beacon.updatePeripheral(with: peripheral)
    let beacon2 = Beacon(peripheral: mockPeripheral(with: .connecting))

    let beacons: [Beacon] = [
      beacon,
      beacon2
    ]
    storage.append(beacons)

    //WHEN
    let result = storage.beaconsForConnect()

    //THEN
    XCTAssert(result.count == 1)
  }

}
