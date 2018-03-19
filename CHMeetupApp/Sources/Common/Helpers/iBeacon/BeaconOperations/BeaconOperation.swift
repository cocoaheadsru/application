//
//  BeaconOperation.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 17/03/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import Foundation

protocol BeaconOperation: class {
  func start()
  func cancel()
  var delegate: BeaconOperationDelegate? { get set }
}

protocol BeaconOperationDelegate: class {
  func operationDidComplete(operation: BeaconOperation)
}
