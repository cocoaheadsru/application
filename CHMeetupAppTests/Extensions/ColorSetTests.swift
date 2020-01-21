//
//  ColorSetTests.swift
//  CHMeetupAppTests
//
//  Created by Ярослав Попов on 09.01.2020.
//  Copyright © 2020 CocoaHeads Community. All rights reserved.
//

import XCTest
@testable import CHMeetupApp

final class ColorSetTests: XCTestCase {
  func allColorsExistsTest() {
    ColorSet.allCases.forEach { XCTAssertNotNil(UIColor.from(colorSet: $0)) }
  }
}
