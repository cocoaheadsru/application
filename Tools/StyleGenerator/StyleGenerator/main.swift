#!/usr/bin/swift

import Foundation

// MARK: - Enums

enum Mode {
  case interactive
  case script
}

enum FileType {
  case json
  case colors
  case fonts

  var type: String {
    switch self {
    case .json:
      return ".json"
    case .colors, .fonts:
      return ".swift"
    }
  }
}

enum ProccesStep: Int {
  case start = 0
  case readJSON
  case generateColors
  case generateFonts
  case end

  var next: ProccesStep {
    if self == .end {
      return self
    }

    return ProccesStep(rawValue: self.rawValue + 1)! //Check this force above
  }
}

// MARK: - Protocols

protocol DescribedError: Error {
  var message: String { get }
}

// MARK: - Properties

let consoleController = ConsoleController()
let fileController = FileController()
var currentStep = ProccesStep.start
let generator = Generator()
var styleFile: StyleFile?
let mode: Mode = .script

// MARK: - Modes

func interactiveMode() {
  consoleController.printMessage("Hello, use me to generate styles from json.")
  var shouldExit = false
  while !shouldExit {
    switch currentStep {

    case .start:
      moveToNextStep()

    case .readJSON:
      createStyleFile()

    case .generateColors:
      generateColorsFile()

    case .generateFonts:
      generateFontsFile()

    case .end:
      shouldExit = true
    }
  }

  exit(1)
}

func scriptMode() {
  createStyleFile()
  if consoleController.inputedOption == .colors {
    generateColorsFile()
  }
  else if consoleController.inputedOption == .fonts {
    generateFontsFile()
  }
}

// MARK: - Functionality

func moveToNextStep() {
  guard mode == .interactive else {
    return
  }
  
  switch currentStep {
  case .start:
    consoleController.printMessage("Enter full path of your .json")
  case .readJSON:
    consoleController.printMessage("Great, now enter path of your Colors.swift")
  case .generateColors:
    consoleController.printMessage("Great, now enter path of your Fonts.swift")
  case .generateFonts, .end:
    consoleController.printMessage("Work is done. Bye")
  }

  currentStep = currentStep.next
}

func createStyleFile() {
  do {
    if styleFile == nil {

      let jsonFilePath = try consoleController.pathFromInput(for: .json)
      styleFile = try FileController.readFile(at: jsonFilePath)

      if styleFile != nil {
        moveToNextStep()
      }
    }
  } catch {
    if let error = error as? DescribedError {
      consoleController.printMessage(error.message, for: .error)
    }
  }
}

func generateColorsFile() {
  if let styleFile = styleFile {
    do {
      let colorsFilePath = try consoleController.pathFromInput(for: .colors)
      let code = try generator.generateSwiftColorsFile(from: styleFile)
      try FileController.write(code: code, in: colorsFilePath)
      moveToNextStep()

    } catch {
      if let error = error as? DescribedError {
        consoleController.printMessage(error.message, for: .error)
      }
    }
  } else {
    currentStep = .readJSON
  }
}

func generateFontsFile() {
  if let styleFile = styleFile {
    do {
      let fontsFilePath = try consoleController.pathFromInput(for: .fonts)
      let code = try generator.generateSwiftFontsFile(from: styleFile)
      try FileController.write(code: code, in: fontsFilePath)
      moveToNextStep()

    } catch {
      if let error = error as? DescribedError {
        consoleController.printMessage(error.message, for: .error)
      }
    }
  } else {
    currentStep = .readJSON
  }
}

// MARK: - Run process

switch mode {
case .interactive:
  interactiveMode()
case .script:
  scriptMode()
}
