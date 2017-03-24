//
//  FontTests.swift
//  StyleGenerator
//
//  Created by Denis on 22.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import XCTest
@testable import StyleGenerator

class FontTests: XCTestCase {

  let factory = TestsParametersFactory()

  func testInitializationWithCorrectValues() {
    let parameters = factory.makeTestParameters(for: .font(.withCorrectValues))
    let font = Font(parameters)
    XCTAssertNotNil(font, "Font should be nil")
  }

  func testInitializationWithNoFontName() {
    let parameters = factory.makeTestParameters(for: .font(.withoutFontName))
    let font = Font(parameters)
    XCTAssertNil(font, "Font should be nil")
  }
}
