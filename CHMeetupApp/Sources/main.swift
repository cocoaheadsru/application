//
//  main.swift
//  CHMeetupApp
//
//  Created by Chingis Gomboev on 06/08/2018.
//  Copyright © 2018 CocoaHeads Community. All rights reserved.
//

import UIKit
import Foundation

class TestingAppDelegate: UIResponder, UIApplicationDelegate {
  override init() {
    RealmController.shared.setup()
  }
}
let isRunningTests = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil

_ = UIApplicationMain(
  CommandLine.argc,
  UnsafeMutableRawPointer(CommandLine.unsafeArgv)
    .bindMemory(
      to: UnsafeMutablePointer<Int8>.self,
      capacity: Int(CommandLine.argc)),
  nil,
  NSStringFromClass(isRunningTests ? TestingAppDelegate.self : AppDelegate.self)
)
