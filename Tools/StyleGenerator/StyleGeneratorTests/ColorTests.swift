//
//  ColorTests.swift
//  StyleGenerator
//
//  Created by Denis on 22.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import XCTest
@testable import StyleGenerator

class ColorTests: XCTestCase {

  let factory = TestsParametersFactory()

  func testInitializationWithCorrectValues() {
    let parameters = factory.makeTestParameters(for: .color(.withCorrectValues))
    let color = Color(parameters)
    XCTAssertNotNil(color, "Color should be created")
  }

  func testInitializationWithoutHexSymbol() {
    let parameters = factory.makeTestParameters(for: .color(.withoutHexSymbol))
    let color = Color(parameters)
    XCTAssertNotNil(color, "Color should be created")
    XCTAssert(color!.hex.contains("#"), "Color should contained '#'")
  }

  func testInitializationWithHexSymbol() {
    let parameters = factory.makeTestParameters(for: .color(.withHexSymbol))
    let color = Color(parameters)
    XCTAssertNotNil(color, "Color should be created")
    XCTAssert(color!.hex.contains("#"), "Color should contained '#'")
  }

  func testInitializationWithNoColorName() {
    let parameters = factory.makeTestParameters(for: .color(.withoutColorName))
    let color = Color(parameters)
    XCTAssertNil(color, "Color should be nil")
  }
}
