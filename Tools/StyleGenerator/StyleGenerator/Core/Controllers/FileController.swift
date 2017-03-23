//
//  FileController.swift
//  StyleGenerator
//
//  Created by Denis on 12.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

final class FileController {

  // MARK: - Nested 

  enum Error: DescribedError {
    case notFound
    case empty
    case wrongJsonParameters

    var message: String {
      switch self {
      case .empty:
        return "File is empty"
      case .notFound:
        return "Couldn't find file"
      case .wrongJsonParameters:
        return "You have wrong parameters in your json file"
      }
    }
  }

  // MARK: - Properties

  private static let fileManager = FileManager.default

  // MARK: - Public

  static func readTemplateParameters(from path: String) throws -> TemplateInputParameters {
    guard let file = FileHandle(forReadingAtPath: path) else {
      throw Error.notFound
    }

    let data = file.readDataToEndOfFile()
    if data.isEmpty {
      throw Error.empty
    }

    let parameters =  try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
    if let parameters = parameters as? TemplateInputParameters {
      return parameters
    } else {
      throw Error.wrongJsonParameters
    }
  }

  static func write(code: TemplateOutputCode, in file: String) throws {
    let fileDestinationUrl = URL(fileURLWithPath: file)
    try code.write(to: fileDestinationUrl, atomically: false, encoding: .utf8)
  }
}
