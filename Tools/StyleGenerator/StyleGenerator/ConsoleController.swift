//
//  ConsoleController.swift
//  StyleGenerator
//
//  Created by Denis on 10.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

class ConsoleController {

  //MARK: - Nested types
  
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
  
  //MARK: - Public

  func pathFromInput(for file: FileType) throws -> String {
    guard var result = getInput(), !result.isEmpty else {
      throw InputError.empty
    }

    result = result.replacingOccurrences(of: String.space, with: String())
    guard result.hasSuffix(file.type) else {
      throw InputError.wrongFormat
    }

    return result
  }

  func getInput() -> String? {

    let keyboard = FileHandle.standardInput
    let inputData = keyboard.availableData
    let strData = String(data: inputData, encoding: String.Encoding.utf8)!
    return strData.trimmingCharacters(in: CharacterSet.newlines)
  }

  func printMessage(_ message: String, to: MessageOutputType = .standard) {
    switch to {
    case .standard:
      print("\u{001B}[;m\(message)")
    case .error:
      fputs("\u{001B}[0;31m\(message)\n", stderr)
      print("\u{001B}[;mPlease, try again")
    }
  }
}
