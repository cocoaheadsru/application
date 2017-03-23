//
//  TestsParametersFactory.swift
//  StyleGenerator
//
//  Created by Denis on 22.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Cocoa
@testable import StyleGenerator

class TestsParametersFactory: NSObject {

  enum TestCase {
    case font(FontCase)
    case color(ColorCase)
  }

  enum FontCase: String {
    case withoutFontName
    case withCorrectValues
  }

  enum ColorCase: String {
    case withoutHexSymbol
    case withHexSymbol
    case withCorrectValues
    case withoutColorName
  }

  // MARK: - Properties

  fileprivate lazy var brokenParameters: [String: Any] = {
    return self.makeBrokenParameters()
  }()

  fileprivate var fontParameters: [[String: Any]] {
    //swiftlint:disable:next force_cast
    return brokenParameters["fonts"] as! [[String : Any]]
  }

  fileprivate var colorParameters: [[String: Any]] {
    //swiftlint:disable:next force_cast
    return brokenParameters["colors"] as! [[String : Any]]
  }

  // MARK: - Font parameters

  func makeTestParameters(for testCase: TestCase) -> [String: Any] {
    switch testCase {
    case .font(let fontCase):
      return firstFontParameter(withTestId: fontCase.rawValue)
    case .color(let colorCase):
      return firstColorParameter(withTestId: colorCase.rawValue)
    }
  }

  // MARK: - Private

  fileprivate func makeBrokenParameters() -> [String: Any] {
    let testBundle = Bundle(for: type(of: self))
    guard let filePath = testBundle.path(forResource: "BrokenParameters", ofType: "json") else {
      return [:]
    }
    do {
      let data = try Data(contentsOf: URL(fileURLWithPath: filePath))
      let parameters = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
      if let parameters = parameters as? [String: Any] {
        return parameters
      } else {
        return [:]
      }
    } catch {
      print("\(error.localizedDescription)")
      return [:]
    }
  }

  fileprivate func firstFontParameter(withTestId testId: String) -> [String: Any] {
    return fontParameters.first(where: { (parameter) -> Bool in
      guard let stringValue = parameter["testId"] as? String else { return false }
      return stringValue == testId
    })!
  }

  fileprivate func firstColorParameter(withTestId testId: String) -> [String: Any] {
    return colorParameters.first(where: { (parameter) -> Bool in
      guard let stringValue = parameter["testId"] as? String else { return false }
      return stringValue == testId
    })!
  }
}

// Mock exit methdos

func exit(with errorMessage: String) {
  print(errorMessage)
}
