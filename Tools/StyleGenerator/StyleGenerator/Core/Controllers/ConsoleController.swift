//
//  ConsoleController.swift
//  StyleGenerator
//
//  Created by Denis on 10.03.17.
//  Copyright © 2017 DenRee. All rights reserved.
//

import Foundation

// MARK: - Options

enum TemplateOption: String {
  case unknown
  case colors
  case fonts
  case styles
}

// MARK: - Input

struct ConsoleInputParameters {
  let option: TemplateOption
  let inputPath: String
  let outputPath: String
}

// MARK: - Console

class ConsoleController {

  // MARK: - Nested types

  enum MessageOutputType {
    case error
    case standard
  }

  enum InputError: DescribedError {
    case emptyPath
    case wrongFileFormat
    case wrongArgumentsFormat
    case wrongArgumentsCount

    var message: String {
      switch self {
      case .emptyPath:
        return "You entered empty path"
      case .wrongFileFormat:
        return "You entered wrong format for file"
      case .wrongArgumentsFormat:
        return "You entered wrong argument"
      case .wrongArgumentsCount:
        return "You entered wrong number of arguments"
      }
    }
  }

  // MARK: - Public

  func obtainInputParameters() throws -> ConsoleInputParameters {
    let arguments = CommandLine.arguments

    let requiredCount = 4
    guard arguments.count == requiredCount else {
      throw InputError.wrongArgumentsCount
    }

    let templateIndex = 1
    guard let option = TemplateOption(rawValue: arguments[templateIndex]) else {
      throw InputError.wrongArgumentsFormat
    }

    let jsonPathIndex = 2
    let jsonPath = arguments[jsonPathIndex]
    if jsonPath.isEmpty {
      throw InputError.emptyPath
    } else if !jsonPath.hasSuffix(".json") {
      throw InputError.wrongFileFormat
    }

    let outputPathIndex = 3
    let outputPath = arguments[outputPathIndex]
    if outputPath.isEmpty {
      throw InputError.emptyPath
    } else if !outputPath.hasSuffix(".swift") {
      throw InputError.wrongFileFormat
    }

    return ConsoleInputParameters(option: option, inputPath: jsonPath, outputPath: outputPath)
  }

  func printMessage(_ message: String, for outputType: MessageOutputType = .standard) {
    switch outputType {
    case .standard:
      print("\(message)")
    case .error:
      fputs("\(message)\n", stderr)
      print("Please, try again")
    }
  }
}
