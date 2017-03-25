#!/usr/bin/swift

import Foundation

// MARK: - Protocols

protocol DescribedError: Error {
  var message: String { get }
}

extension NSError: DescribedError {
  var message: String {
    return localizedDescription
  }
}

// MARK: - Properties

let consoleController = ConsoleController()
let fileController = FileController()
var generator = TemplateGenerator()

// MARK: - Exit

func exit(with error: Error) {
  if let error = error as? DescribedError {
    exit(with: error.message)
  } else {
    exit(with: error.localizedDescription)
  }
}

func exit(with errorMessage: String) {
  consoleController.printMessage(errorMessage, for: .error)
  exit(1)
}

// MARK: - Functionality

func runGenerationProccess() {
  do {
    let parameters = try consoleController.obtainInputParameters()
    if parameters.option != .unknown {
      generator.generateFiles(for: parameters)
      exit(0)
    } else {
      exit(with: "Your entered wrong options")
    }
  } catch {
    exit(with: error)
  }
}

// MARK: - Run process

runGenerationProccess()
