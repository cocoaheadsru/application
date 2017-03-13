//
//  ConsoleController.swift
//  StyleGenerator
//
//  Created by Denis on 10.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

class ConsoleController {

  // MARK: - Nested types
  enum MessageOutputType {
    case error
    case standard
  }

  enum InputError: DescribedError {
    case empty
    case wrongFormat

    var message: String {
      switch self {
      case .empty:
        return "You enter empty path"
      case .wrongFormat:
        return "You enter wrong format"
      }
    }
  }

  // MARK: - Public
  func pathFromInput(for file: FileType) throws -> String {
    let input = getInput()

    if input.isEmpty {
      throw InputError.empty
    }

    let result = input.replacingOccurrences(of: String.space, with: "")
    guard result.hasSuffix(file.type) else {
      throw InputError.wrongFormat
    }

    return result
  }

  func getInput() -> String {

    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData

    if let strData = String(data: inputData, encoding: String.Encoding.utf8) {
      return strData.trimmingCharacters(in: CharacterSet.newlines)
    } else {
      return ""
    }
  }

  func printMessage(_ message: String, for: MessageOutputType = .standard) {
    switch `for` {
    case .standard:
      print("\(message)")
    case .error:
      fputs("\(message)\n", stderr)
      print("Please, try again")
    }
  }
}
