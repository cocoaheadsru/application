//
//  FileController.swift
//  StyleGenerator
//
//  Created by Denis on 12.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

final class FileController {

  //MARK: - Nested 

  enum FileReadError: DescribedError {
    case notFound
    case empty
    case wrongJsonParameters
    case systemError(description: String)

    var message: String {
      switch self {
      case .empty:
        return "File is empty"
      case .notFound:
        return "Couldn't find file"
      case .wrongJsonParameters:
        return "You have wrong parameters in your json file"
      case .systemError(let description):
        return description
      }
    }
  }

  enum FileWriteError: DescribedError {
    case systemError(description: String)

    var message: String {
      switch self {
      case .systemError(let description):
        return description
      }
    }
  }

  //MARK: - Public

  static func readFile(at path: String) throws -> StyleFile {

    guard let file = FileHandle(forUpdatingAtPath: path) else {
      throw FileReadError.notFound
    }

    let data = file.readDataToEndOfFile()
    guard !data.isEmpty else {
      throw FileReadError.empty
    }

    do {
      let parameters =  try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
      if let parameters = parameters as? Dictionary<String,[StyleParameters]> {
        return StyleFile(from: parameters)
      } else {
        throw FileReadError.wrongJsonParameters
      }
    } catch let error as NSError {
      throw FileReadError.systemError(description: error.localizedDescription)
    }
  }

  static func write(code: String, in file: String) throws {
    do {

      // Try to write to disk
      let fileDestinationUrl = URL(fileURLWithPath: file)
      try code.write(to: fileDestinationUrl, atomically: false, encoding: .utf8)

    } catch let error as NSError {
      throw FileWriteError.systemError(description: error.localizedDescription)
    }
  }
}
